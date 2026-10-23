module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    struct Drop has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        price: u64,
        max_supply: u64,
        minted: u64,
        end_ms: u64,
        royalty_bps: u64,
    }

    struct DropNFT has store, key {
        id: 0x2::object::UID,
        drop_id: 0x2::object::ID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct DropCreated has copy, drop {
        drop_id: 0x2::object::ID,
        creator: address,
        price: u64,
        max_supply: u64,
    }

    struct MintEvent has copy, drop {
        drop_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        number: u64,
        minter: address,
        creator: address,
        referrer: address,
        price: u64,
        creator_amount: u64,
        referrer_amount: u64,
        fee_amount: u64,
    }

    struct Phase has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        per_wallet: u64,
        cap: u64,
        minted: u64,
        start_ms: u64,
        end_ms: u64,
        kind: u8,
        merkle_root: vector<u8>,
        list_uri: 0x1::string::String,
        holder_type: 0x1::ascii::String,
    }

    struct PhasesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WalletMintKey has copy, drop, store {
        phase: u64,
        who: address,
    }

    struct PhaseMintEvent has copy, drop {
        drop_id: 0x2::object::ID,
        phase: u64,
        nft_id: 0x2::object::ID,
        minter: address,
        referrer: address,
        price: u64,
        creator_amount: u64,
        referrer_amount: u64,
        fee_amount: u64,
    }

    struct KioskOnlyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ImageCountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ImageKey has copy, drop, store {
        n: u64,
    }

    struct ManifestKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CardKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RefBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_images(arg0: &mut Drop, arg1: vector<0x1::string::String>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        let v0 = image_count(arg0);
        let v1 = v0;
        assert!(v0 + 0x1::vector::length<0x1::string::String>(&arg1) <= arg0.max_supply, 22);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v3 = v1 + 1;
            v1 = v3;
            let v4 = ImageKey{n: v3};
            0x2::dynamic_field::add<ImageKey, 0x1::string::String>(&mut arg0.id, v4, *0x1::vector::borrow<0x1::string::String>(&arg1, v2));
            v2 = v2 + 1;
        };
        let v5 = ImageCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ImageCountKey>(&arg0.id, v5)) {
            let v6 = ImageCountKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ImageCountKey, u64>(&mut arg0.id, v6) = v1;
        } else {
            let v7 = ImageCountKey{dummy_field: false};
            0x2::dynamic_field::add<ImageCountKey, u64>(&mut arg0.id, v7, v1);
        };
    }

    public fun add_phase(arg0: &mut Drop, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: 0x1::string::String, arg10: 0x1::ascii::String, arg11: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == arg0.creator, 8);
        assert!(arg0.minted == 0, 19);
        assert!(arg7 <= 3, 11);
        assert!(arg7 != 1 || 0x1::vector::length<u8>(&arg8) == 32, 11);
        assert!(arg6 == 0 || arg6 > arg5, 11);
        let v0 = PhasesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PhasesKey>(&arg0.id, v0)) {
            let v1 = PhasesKey{dummy_field: false};
            0x2::dynamic_field::add<PhasesKey, vector<Phase>>(&mut arg0.id, v1, 0x1::vector::empty<Phase>());
        };
        let v2 = PhasesKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PhasesKey, vector<Phase>>(&mut arg0.id, v2);
        assert!(0x1::vector::length<Phase>(v3) < 3, 10);
        let v4 = Phase{
            name        : arg1,
            price       : arg2,
            per_wallet  : arg3,
            cap         : arg4,
            minted      : 0,
            start_ms    : arg5,
            end_ms      : arg6,
            kind        : arg7,
            merkle_root : arg8,
            list_uri    : arg9,
            holder_type : arg10,
        };
        0x1::vector::push_back<Phase>(v3, v4);
        if (0x1::vector::length<Phase>(v3) == 1 || arg2 < arg0.price) {
            arg0.price = arg2;
        };
    }

    public fun card(arg0: &Drop) : 0x1::string::String {
        let v0 = CardKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CardKey>(&arg0.id, v0)) {
            let v2 = CardKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CardKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            0x1::string::utf8(b"")
        }
    }

    public fun close(arg0: &mut Drop, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 8);
        arg0.max_supply = arg0.minted;
    }

    public fun create_drop(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 > 0, 6);
        assert!(arg6 <= 2500, 5);
        let v0 = Drop{
            id          : 0x2::object::new(arg7),
            creator     : 0x2::tx_context::sender(arg7),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            price       : arg3,
            max_supply  : arg4,
            minted      : 0,
            end_ms      : arg5,
            royalty_bps : arg6,
        };
        let v1 = 0x2::object::id<Drop>(&v0);
        let v2 = DropCreated{
            drop_id    : v1,
            creator    : v0.creator,
            price      : arg3,
            max_supply : arg4,
        };
        0x2::event::emit<DropCreated>(v2);
        0x2::transfer::share_object<Drop>(v0);
        v1
    }

    public fun creator(arg0: &Drop) : address {
        arg0.creator
    }

    public fun eff_ref_bps(arg0: &Drop, arg1: u64) : u64 {
        let v0 = RefBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RefBpsKey>(&arg0.id, v0)) {
            let v2 = RefBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<RefBpsKey, u64>(&arg0.id, v2)
        } else {
            arg1
        }
    }

    public fun has_phases(arg0: &Drop) : bool {
        let v0 = PhasesKey{dummy_field: false};
        0x2::dynamic_field::exists<PhasesKey>(&arg0.id, v0)
    }

    public fun has_ref_bps(arg0: &Drop) : bool {
        let v0 = RefBpsKey{dummy_field: false};
        0x2::dynamic_field::exists<RefBpsKey>(&arg0.id, v0)
    }

    public fun image_count(arg0: &Drop) : u64 {
        let v0 = ImageCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ImageCountKey>(&arg0.id, v0)) {
            let v2 = ImageCountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ImageCountKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun image_for(arg0: &Drop, arg1: u64) : 0x1::string::String {
        let v0 = ImageKey{n: arg1};
        if (0x2::dynamic_field::exists<ImageKey>(&arg0.id, v0)) {
            let v2 = ImageKey{n: arg1};
            *0x2::dynamic_field::borrow<ImageKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            arg0.image_url
        }
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DROP>(arg0, arg1);
        let v1 = 0x2::display::new<DropNFT>(&v0, arg1);
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{number}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://tapdrop.link/m/{drop_id}"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://tapdrop.link"));
        0x2::display::add<DropNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"TapDrop"));
        0x2::display::update_version<DropNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<DropNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DropNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DropNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DropNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_blob_id(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 64) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 >= 65 && v3 <= 90) {
                true
            } else if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 == 45) {
                true
            } else {
                v3 == 95
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun is_kiosk_only(arg0: &Drop) : bool {
        let v0 = KioskOnlyKey{dummy_field: false};
        0x2::dynamic_field::exists<KioskOnlyKey>(&arg0.id, v0)
    }

    public(friend) fun lock_into_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<DropNFT>, arg3: DropNFT) {
        to_kiosk(arg0, arg1, arg2, arg3);
    }

    fun lt_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0) && v0 < 0x1::vector::length<u8>(arg1)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        0x1::vector::length<u8>(arg0) < 0x1::vector::length<u8>(arg1)
    }

    public fun max_supply(arg0: &Drop) : u64 {
        arg0.max_supply
    }

    public fun merkle_verify(arg0: &vector<u8>, arg1: address, arg2: &vector<vector<u8>>) : bool {
        let v0 = 0x1::hash::sha3_256(0x2::bcs::to_bytes<address>(&arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(arg2, v1);
            let v3 = b"";
            if (lt_bytes(&v0, &v2)) {
                0x1::vector::append<u8>(&mut v3, v0);
                0x1::vector::append<u8>(&mut v3, v2);
            } else {
                0x1::vector::append<u8>(&mut v3, v2);
                0x1::vector::append<u8>(&mut v3, v0);
            };
            v0 = 0x1::hash::sha3_256(v3);
            v1 = v1 + 1;
        };
        &v0 == arg0
    }

    public fun mint(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : DropNFT {
        let v0 = PhasesKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<PhasesKey>(&arg1.id, v0), 9);
        assert!(!is_kiosk_only(arg1), 20);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.price, 1);
        assert!(arg1.minted < arg1.max_supply, 2);
        assert!(arg1.end_ms == 0 || 0x2::clock::timestamp_ms(arg5) < arg1.end_ms, 3);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = eff_ref_bps(arg1, arg4);
        let v3 = arg3 != @0x0 && v2 > 0;
        assert!(!v3 || arg3 != v1 && arg3 != arg1.creator, 7);
        let (v4, v5, v6) = quote_with(arg0, arg1.price, v3, v2);
        let (v7, v8) = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v1) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg1.creator)) {
            (v4 + v6, 0)
        } else {
            (v4, v6)
        };
        if (arg1.price == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v8, arg6), 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg0));
            };
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v5, arg6), arg3);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.creator);
        };
        arg1.minted = arg1.minted + 1;
        let v9 = DropNFT{
            id          : 0x2::object::new(arg6),
            drop_id     : 0x2::object::id<Drop>(arg1),
            number      : arg1.minted,
            name        : arg1.name,
            description : arg1.description,
            image_url   : image_for(arg1, arg1.minted),
        };
        let v10 = if (v3) {
            arg3
        } else {
            @0x0
        };
        let v11 = MintEvent{
            drop_id         : 0x2::object::id<Drop>(arg1),
            nft_id          : 0x2::object::id<DropNFT>(&v9),
            number          : arg1.minted,
            minter          : v1,
            creator         : arg1.creator,
            referrer        : v10,
            price           : arg1.price,
            creator_amount  : v7,
            referrer_amount : v5,
            fee_amount      : v8,
        };
        0x2::event::emit<MintEvent>(v11);
        v9
    }

    entry fun mint_phase_allowlist(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = PhasesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg1.id, v0);
        assert!(arg2 < 0x1::vector::length<Phase>(v1), 11);
        let v2 = merkle_verify(&0x1::vector::borrow<Phase>(v1, arg2).merkle_root, 0x2::tx_context::sender(arg8), &arg3);
        assert!(!is_kiosk_only(arg1), 20);
        let v3 = phase_mint(arg0, arg1, arg2, 1, v2, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<DropNFT>(v3, 0x2::tx_context::sender(arg8));
    }

    entry fun mint_phase_allowlist_kiosk(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: vector<vector<u8>>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<DropNFT>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = PhasesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg1.id, v0);
        assert!(arg2 < 0x1::vector::length<Phase>(v1), 11);
        let v2 = merkle_verify(&0x1::vector::borrow<Phase>(v1, arg2).merkle_root, 0x2::tx_context::sender(arg11), &arg3);
        to_kiosk(arg4, arg5, arg6, phase_mint(arg0, arg1, arg2, 1, v2, arg7, arg8, arg9, arg10, arg11));
    }

    entry fun mint_phase_holder<T0: key>(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: &T0, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 23
    }

    entry fun mint_phase_holder_kiosk<T0: store + key>(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<DropNFT>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg3, arg4), 21);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg3, arg5), 18);
        let v0 = PhasesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg1.id, v0);
        assert!(arg2 < 0x1::vector::length<Phase>(v1), 11);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == 0x1::vector::borrow<Phase>(v1, arg2).holder_type, 18);
        to_kiosk(arg3, arg4, arg6, phase_mint(arg0, arg1, arg2, 2, true, arg7, arg8, arg9, arg10, arg11));
    }

    entry fun mint_phase_holder_v2<T0: store + key>(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: T0, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = PhasesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg1.id, v0);
        assert!(arg2 < 0x1::vector::length<Phase>(v1), 11);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == 0x1::vector::borrow<Phase>(v1, arg2).holder_type, 18);
        assert!(!is_kiosk_only(arg1), 20);
        let v2 = phase_mint(arg0, arg1, arg2, 2, true, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<DropNFT>(v2, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<T0>(arg3, 0x2::tx_context::sender(arg8));
    }

    entry fun mint_phase_public(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_kiosk_only(arg1), 20);
        let v0 = phase_mint(arg0, arg1, arg2, 0, true, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<DropNFT>(v0, 0x2::tx_context::sender(arg7));
    }

    entry fun mint_phase_public_kiosk(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<DropNFT>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        to_kiosk(arg3, arg4, arg5, phase_mint(arg0, arg1, arg2, 0, true, arg6, arg7, arg8, arg9, arg10));
    }

    public fun mint_ticket_message(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) : vector<u8> {
        let v0 = b"tapdrop:mint:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    entry fun mint_to_sender(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<DropNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun minted(arg0: &Drop) : u64 {
        arg0.minted
    }

    public fun new_drop(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Drop {
        assert!(arg3 > 0, 6);
        assert!(arg4 <= 2500, 5);
        Drop{
            id          : 0x2::object::new(arg5),
            creator     : 0x2::tx_context::sender(arg5),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            price       : 0,
            max_supply  : arg3,
            minted      : 0,
            end_ms      : 0,
            royalty_bps : arg4,
        }
    }

    public fun nft_drop_id(arg0: &DropNFT) : 0x2::object::ID {
        arg0.drop_id
    }

    public fun nft_image_url(arg0: &DropNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun nft_number(arg0: &DropNFT) : u64 {
        arg0.number
    }

    fun phase_mint(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: u8, arg4: bool, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : DropNFT {
        assert!(has_phases(arg1), 11);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = PhasesKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg1.id, v2);
        assert!(arg2 < 0x1::vector::length<Phase>(v3), 11);
        let v4 = *0x1::vector::borrow<Phase>(v3, arg2);
        assert!(v4.kind == arg3, 17);
        assert!(arg3 != 1 || arg4, 16);
        assert!(v0 >= v4.start_ms, 12);
        assert!(v4.end_ms == 0 || v0 < v4.end_ms, 13);
        assert!(arg1.minted < arg1.max_supply, 2);
        assert!(v4.cap == 0 || v4.minted < v4.cap, 14);
        let v5 = WalletMintKey{
            phase : arg2,
            who   : v1,
        };
        let v6 = if (0x2::dynamic_field::exists<WalletMintKey>(&arg1.id, v5)) {
            *0x2::dynamic_field::borrow<WalletMintKey, u64>(&arg1.id, v5)
        } else {
            0
        };
        assert!(v4.per_wallet == 0 || v6 < v4.per_wallet, 15);
        if (0x2::dynamic_field::exists<WalletMintKey>(&arg1.id, v5)) {
            *0x2::dynamic_field::borrow_mut<WalletMintKey, u64>(&mut arg1.id, v5) = v6 + 1;
        } else {
            0x2::dynamic_field::add<WalletMintKey, u64>(&mut arg1.id, v5, 1);
        };
        let v7 = PhasesKey{dummy_field: false};
        let v8 = 0x1::vector::borrow_mut<Phase>(0x2::dynamic_field::borrow_mut<PhasesKey, vector<Phase>>(&mut arg1.id, v7), arg2);
        v8.minted = v8.minted + 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v4.price, 1);
        let v9 = eff_ref_bps(arg1, arg7);
        let v10 = arg6 != @0x0 && v9 > 0;
        assert!(!v10 || arg6 != v1 && arg6 != arg1.creator, 7);
        let (v11, v12, v13) = quote_with(arg0, v4.price, v10, v9);
        let (v14, v15) = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v1) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg1.creator)) {
            (v11 + v13, 0)
        } else {
            (v11, v13)
        };
        if (v4.price == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        } else {
            if (v15 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v15, arg9), 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg0));
            };
            if (v12 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v12, arg9), arg6);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg1.creator);
        };
        arg1.minted = arg1.minted + 1;
        let v16 = DropNFT{
            id          : 0x2::object::new(arg9),
            drop_id     : 0x2::object::id<Drop>(arg1),
            number      : arg1.minted,
            name        : arg1.name,
            description : arg1.description,
            image_url   : image_for(arg1, arg1.minted),
        };
        let v17 = if (v10) {
            arg6
        } else {
            @0x0
        };
        let v18 = MintEvent{
            drop_id         : 0x2::object::id<Drop>(arg1),
            nft_id          : 0x2::object::id<DropNFT>(&v16),
            number          : arg1.minted,
            minter          : v1,
            creator         : arg1.creator,
            referrer        : v17,
            price           : v4.price,
            creator_amount  : v14,
            referrer_amount : v12,
            fee_amount      : v15,
        };
        0x2::event::emit<MintEvent>(v18);
        let v19 = PhaseMintEvent{
            drop_id         : 0x2::object::id<Drop>(arg1),
            phase           : arg2,
            nft_id          : 0x2::object::id<DropNFT>(&v16),
            minter          : v1,
            referrer        : v17,
            price           : v4.price,
            creator_amount  : v14,
            referrer_amount : v12,
            fee_amount      : v15,
        };
        0x2::event::emit<PhaseMintEvent>(v19);
        v16
    }

    public fun phase_per_wallet(arg0: &Drop, arg1: u64) : u64 {
        let v0 = PhasesKey{dummy_field: false};
        0x1::vector::borrow<Phase>(0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg0.id, v0), arg1).per_wallet
    }

    public fun phases(arg0: &Drop) : vector<Phase> {
        if (has_phases(arg0)) {
            let v1 = PhasesKey{dummy_field: false};
            *0x2::dynamic_field::borrow<PhasesKey, vector<Phase>>(&arg0.id, v1)
        } else {
            0x1::vector::empty<Phase>()
        }
    }

    public fun price(arg0: &Drop) : u64 {
        arg0.price
    }

    public fun quote(arg0: u64, arg1: bool, arg2: u64) : (u64, u64, u64) {
        quote_bps(arg0, arg1, arg2, 250)
    }

    fun quote_bps(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(arg2 <= 1000, 4);
        let v0 = (((arg0 as u128) * (arg3 as u128) / (10000 as u128)) as u64);
        let v1 = if (arg1) {
            (((arg0 as u128) * (arg2 as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        (arg0 - v0 - v1, v1, v0)
    }

    public fun quote_with(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64) {
        quote_bps(arg1, arg2, arg3, 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::mint_fee_bps(arg0))
    }

    public fun royalty_bps(arg0: &Drop) : u64 {
        arg0.royalty_bps
    }

    public fun set_card(arg0: &mut Drop, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        assert!(is_blob_id(&arg1), 24);
        let v0 = CardKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CardKey>(&arg0.id, v0)) {
            let v1 = CardKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<CardKey, 0x1::string::String>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = CardKey{dummy_field: false};
            0x2::dynamic_field::add<CardKey, 0x1::string::String>(&mut arg0.id, v2, arg1);
        };
    }

    public fun set_kiosk_only(arg0: &mut Drop, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        assert!(arg0.minted == 0, 19);
        let v0 = if (arg1) {
            let v1 = KioskOnlyKey{dummy_field: false};
            !0x2::dynamic_field::exists<KioskOnlyKey>(&arg0.id, v1)
        } else {
            false
        };
        if (v0) {
            let v2 = KioskOnlyKey{dummy_field: false};
            0x2::dynamic_field::add<KioskOnlyKey, bool>(&mut arg0.id, v2, true);
        };
        let v3 = if (!arg1) {
            let v4 = KioskOnlyKey{dummy_field: false};
            0x2::dynamic_field::exists<KioskOnlyKey>(&arg0.id, v4)
        } else {
            false
        };
        if (v3) {
            let v5 = KioskOnlyKey{dummy_field: false};
            0x2::dynamic_field::remove<KioskOnlyKey, bool>(&mut arg0.id, v5);
        };
    }

    public fun set_manifest(arg0: &mut Drop, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        let v0 = ManifestKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ManifestKey>(&arg0.id, v0)) {
            let v1 = ManifestKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ManifestKey, 0x1::string::String>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = ManifestKey{dummy_field: false};
            0x2::dynamic_field::add<ManifestKey, 0x1::string::String>(&mut arg0.id, v2, arg1);
        };
    }

    public fun set_ref_bps(arg0: &mut Drop, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 8);
        assert!(arg1 <= 1000, 4);
        let v0 = RefBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RefBpsKey>(&arg0.id, v0)) {
            let v1 = RefBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<RefBpsKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = RefBpsKey{dummy_field: false};
            0x2::dynamic_field::add<RefBpsKey, u64>(&mut arg0.id, v2, arg1);
        };
    }

    public fun share_drop(arg0: Drop) {
        let v0 = DropCreated{
            drop_id    : 0x2::object::id<Drop>(&arg0),
            creator    : arg0.creator,
            price      : arg0.price,
            max_supply : arg0.max_supply,
        };
        0x2::event::emit<DropCreated>(v0);
        0x2::transfer::share_object<Drop>(arg0);
    }

    public(friend) fun social_mint(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: &mut Drop, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : DropNFT {
        phase_mint(arg0, arg1, arg2, 3, true, arg3, arg4, arg5, arg6, arg7)
    }

    fun to_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<DropNFT>, arg3: DropNFT) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 21);
        0x2::kiosk::lock<DropNFT>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun uid(arg0: &Drop) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Drop) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun wallet_minted(arg0: &Drop, arg1: u64, arg2: address) : u64 {
        let v0 = WalletMintKey{
            phase : arg1,
            who   : arg2,
        };
        if (0x2::dynamic_field::exists<WalletMintKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<WalletMintKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

