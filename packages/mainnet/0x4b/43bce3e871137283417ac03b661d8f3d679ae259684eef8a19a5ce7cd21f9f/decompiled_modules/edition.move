module 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::edition {
    struct EDITION has drop {
        dummy_field: bool,
    }

    struct EditionVault has key {
        id: 0x2::object::UID,
        version: u64,
        minted: u16,
        balances: 0x2::bag::Bag,
        acc_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        treasury_accrued: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Edition has store, key {
        id: 0x2::object::UID,
        serial: u16,
        watermark: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct EditionSale has key {
        id: 0x2::object::UID,
        version: u64,
        price: u64,
        paused: bool,
        treasury_recipient: address,
        accepted: vector<0x1::type_name::TypeName>,
    }

    struct EditionSold has copy, drop {
        serial: u16,
        buyer: address,
        referrer_code: 0x1::string::String,
        price_paid: u64,
        coin_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct EditionMintedDirect has copy, drop {
        serial: u16,
        recipient: address,
        timestamp_ms: u64,
    }

    struct EditionSaleUpdated has copy, drop {
        field: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct TreasuryAccruedWithdrawn has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun claim<T0>(arg0: &mut EditionVault, arg1: &mut Edition, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_vault_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = map_get_or_zero(&arg0.acc_per_share, &v0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.watermark, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.watermark, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.watermark, v0, v1);
        };
        let v2 = v1 - map_get_or_zero(&arg1.watermark, &v0);
        if (v2 == 0) {
            0x2::coin::zero<T0>(arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), v2), arg2)
        }
    }

    public fun acc_per_share_of<T0>(arg0: &EditionVault) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        map_get_or_zero(&arg0.acc_per_share, &v0)
    }

    public(friend) fun accrue<T0>(arg0: &mut EditionVault, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_version(arg0);
        let v0 = 0x2::coin::value<T0>(arg1) * 300 / 10000;
        if (v0 == 0) {
            return
        };
        let v1 = v0 / (100 as u64);
        let v2 = 0x1::type_name::with_original_ids<T0>();
        let v3 = &mut arg0.acc_per_share;
        bump(v3, v2, v1);
        let v4 = &mut arg0.treasury_accrued;
        bump(v4, v2, v1 * ((100 - arg0.minted) as u64) + v0 - v1 * (100 as u64));
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v2)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v0, arg2)));
    }

    public fun add_sale_accepted_coin<T0>(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::MasterAdminCap, arg1: &mut EditionSale, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock) {
        assert_sale_version(arg1);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 6, 12);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.accepted, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.accepted, v0);
        };
        let v1 = EditionSaleUpdated{
            field        : 0x1::string::utf8(b"accepted_coin_added"),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EditionSaleUpdated>(v1);
    }

    fun assert_sale_version(arg0: &EditionSale) {
        assert!(arg0.version == 1, 0);
    }

    fun assert_vault_version(arg0: &EditionVault) {
        assert!(arg0.version == 1, 0);
    }

    fun bump(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg0, arg1, arg2);
        };
    }

    entry fun buy_edition<T0>(arg0: &mut EditionSale, arg1: &mut EditionVault, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        buy_edition_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun buy_edition_inner<T0>(arg0: &EditionSale, arg1: &mut EditionVault, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_sale_version(arg0);
        assert_vault_version(arg1);
        assert!(!arg0.paused, 1);
        assert!(arg1.minted < 100, 2);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.accepted, &v0), 5);
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.price, 3);
        assert!(0x1::string::length(&arg3) <= 20, 4);
        sale_recipient(arg0);
        if (0x2::coin::value<T0>(&arg2) > arg0.price) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg0.price, arg5), arg0.treasury_recipient);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.treasury_recipient);
        };
        let v1 = mint(arg1, arg5);
        let v2 = EditionSold{
            serial        : v1.serial,
            buyer         : 0x2::tx_context::sender(arg5),
            referrer_code : arg3,
            price_paid    : arg0.price,
            coin_type     : v0,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EditionSold>(v2);
        0x2::transfer::public_transfer<Edition>(v1, 0x2::tx_context::sender(arg5));
    }

    entry fun claim_to_sender<T0>(arg0: &mut EditionVault, arg1: &mut Edition, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun edition_sale_version(arg0: &EditionSale) : u64 {
        arg0.version
    }

    public fun edition_vault_version(arg0: &EditionVault) : u64 {
        arg0.version
    }

    fun init(arg0: EDITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EDITION>(arg0, arg1);
        let v1 = 0x2::display::new<Edition>(&v0, arg1);
        0x2::display::add<Edition>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Albuspaths Edition #{serial}"));
        0x2::display::add<Edition>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.albuspaths.com/edition/{serial}.jpg"));
        0x2::display::add<Edition>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Number {serial} of a fixed edition of 100."));
        0x2::display::update_version<Edition>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Edition>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = new_vault(arg1);
        0x2::transfer::share_object<EditionVault>(v2);
        0x2::transfer::share_object<EditionSale>(new_sale(arg1));
    }

    fun map_get_or_zero(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun migrate_edition_sale(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut EditionSale) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    public fun migrate_edition_vault(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut EditionVault) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    fun mint(arg0: &mut EditionVault, arg1: &mut 0x2::tx_context::TxContext) : Edition {
        assert!(arg0.minted < 100, 2);
        arg0.minted = arg0.minted + 1;
        Edition{
            id        : 0x2::object::new(arg1),
            serial    : arg0.minted,
            watermark : arg0.acc_per_share,
        }
    }

    public fun mint_direct(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::MasterAdminCap, arg1: &EditionSale, arg2: &mut EditionVault, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_sale_version(arg1);
        assert_vault_version(arg2);
        assert!(arg3 != @0x0, 7);
        let v0 = mint(arg2, arg5);
        let v1 = EditionMintedDirect{
            serial       : v0.serial,
            recipient    : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EditionMintedDirect>(v1);
        0x2::transfer::public_transfer<Edition>(v0, arg3);
    }

    public fun minted(arg0: &EditionVault) : u16 {
        arg0.minted
    }

    fun new_sale(arg0: &mut 0x2::tx_context::TxContext) : EditionSale {
        EditionSale{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            price              : 3000000000,
            paused             : false,
            treasury_recipient : @0x0,
            accepted           : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    fun new_vault(arg0: &mut 0x2::tx_context::TxContext) : EditionVault {
        EditionVault{
            id               : 0x2::object::new(arg0),
            version          : 1,
            minted           : 0,
            balances         : 0x2::bag::new(arg0),
            acc_per_share    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            treasury_accrued : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    public fun remove_sale_accepted_coin<T0>(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::MasterAdminCap, arg1: &mut EditionSale, arg2: &0x2::clock::Clock) {
        assert_sale_version(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.accepted, &v0);
        if (v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.accepted, v2);
        };
        let v3 = EditionSaleUpdated{
            field        : 0x1::string::utf8(b"accepted_coin_removed"),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EditionSaleUpdated>(v3);
    }

    public fun sale_paused(arg0: &EditionSale) : bool {
        arg0.paused
    }

    public fun sale_price(arg0: &EditionSale) : u64 {
        arg0.price
    }

    public(friend) fun sale_recipient(arg0: &EditionSale) : address {
        assert!(arg0.treasury_recipient != @0x0, 13);
        arg0.treasury_recipient
    }

    public fun sale_recipient_raw(arg0: &EditionSale) : address {
        arg0.treasury_recipient
    }

    public fun serial(arg0: &Edition) : u16 {
        arg0.serial
    }

    public fun set_sale_paused(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::CharacterAdminCap, arg1: &mut EditionSale, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_sale_version(arg1);
        arg1.paused = arg2;
        let v0 = EditionSaleUpdated{
            field        : 0x1::string::utf8(b"paused"),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EditionSaleUpdated>(v0);
    }

    public fun set_sale_price(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::MasterAdminCap, arg1: &mut EditionSale, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_sale_version(arg1);
        assert!(arg2 > 0, 10);
        arg1.price = arg2;
        let v0 = EditionSaleUpdated{
            field        : 0x1::string::utf8(b"price"),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EditionSaleUpdated>(v0);
    }

    public fun set_sale_recipient(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::MasterAdminCap, arg1: &mut EditionSale, arg2: address, arg3: &0x2::clock::Clock) {
        assert_sale_version(arg1);
        assert!(arg2 != @0x0, 7);
        arg1.treasury_recipient = arg2;
        let v0 = EditionSaleUpdated{
            field        : 0x1::string::utf8(b"recipient"),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EditionSaleUpdated>(v0);
    }

    public fun share_bps() : u64 {
        300
    }

    public fun treasury_accrued_of<T0>(arg0: &EditionVault) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        map_get_or_zero(&arg0.treasury_accrued, &v0)
    }

    public fun vault_balance_of<T0>(arg0: &EditionVault) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun watermark_of<T0>(arg0: &Edition) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        map_get_or_zero(&arg0.watermark, &v0)
    }

    public fun withdraw_treasury_accrued<T0>(arg0: &0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::MasterAdminCap, arg1: &mut EditionVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_version(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = map_get_or_zero(&arg1.treasury_accrued, &v0);
        assert!(v1 > 0, 8);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.treasury_accrued, &v0) = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = TreasuryAccruedWithdrawn{
            coin_type : v0,
            amount    : v1,
        };
        0x2::event::emit<TreasuryAccruedWithdrawn>(v2);
    }

    // decompiled from Move bytecode v7
}

