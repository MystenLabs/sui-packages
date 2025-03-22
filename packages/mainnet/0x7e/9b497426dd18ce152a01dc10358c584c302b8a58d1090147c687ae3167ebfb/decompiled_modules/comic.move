module 0x7e9b497426dd18ce152a01dc10358c584c302b8a58d1090147c687ae3167ebfb::comic {
    struct COMIC has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RegistryMintCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AllowedDonationCoins has key {
        id: 0x2::object::UID,
        allowed_coins: 0x2::table::Table<0x1::type_name::TypeName, bool>,
    }

    struct UserComicRegistry has key {
        id: 0x2::object::UID,
        comic_unique_id: 0x1::string::String,
        total_donated_value: u64,
        image_url: 0x1::string::String,
        language: 0x1::string::String,
        comic_read: bool,
    }

    struct ReadComicData has store, key {
        id: 0x2::object::UID,
        comic_language: 0x1::string::String,
    }

    struct DonateComicData<phantom T0> has store, key {
        id: 0x2::object::UID,
        comic_language: 0x1::string::String,
        donation: 0x2::balance::Balance<T0>,
    }

    struct ParentComic has store, key {
        id: 0x2::object::UID,
        comic_unique_id: 0x1::string::String,
        available_donation: u64,
        total_reads: u64,
    }

    struct Comic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: vector<0x1::string::String>,
        charity_address: 0x1::option::Option<address>,
        total_donation: u64,
        donations_after_last_withdraw: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        admin: address,
        subscribed_by: u64,
        language: 0x1::string::String,
        users_read_page_count: 0x2::table::Table<address, u64>,
    }

    struct ParentComicMintEvent has copy, drop {
        parent_comic_id: 0x2::object::ID,
        comic_unique_id: 0x1::string::String,
    }

    struct ChildComicMintEvent has copy, drop {
        child_comic_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: vector<0x1::string::String>,
        charity_address: 0x1::option::Option<address>,
        admin: address,
        language: 0x1::string::String,
    }

    struct UserRegistryMintEvent has copy, drop {
        registry_id: 0x2::object::ID,
        user: address,
    }

    struct WithdrawDonationEvent has copy, drop {
        child_comic_id: 0x2::object::ID,
        receiving_comic_language: 0x1::string::String,
        withdraw_coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ReceiveReadComicDataEvent has copy, drop {
        parent_comic_id: 0x2::object::ID,
        language: 0x1::string::String,
    }

    struct ReceiveDonateComicDataEvent has copy, drop {
        parent_comic_id: 0x2::object::ID,
        language: 0x1::string::String,
        received_amount: u64,
    }

    struct ReadComicEvent has copy, drop {
        comic_unique_id: 0x1::string::String,
        read_comic_data_id: 0x2::object::ID,
        language: 0x1::string::String,
        reader: address,
    }

    struct DonateComicEvent has copy, drop {
        comic_unique_id: 0x1::string::String,
        donate_comic_data_id: 0x2::object::ID,
        allowed_donation_coin_id: 0x2::object::ID,
        language: 0x1::string::String,
        donation_amount: u64,
        donor: address,
    }

    struct RegistryMintCapEvent has copy, drop {
        registry_mint_cap_id: 0x2::object::ID,
        recipient: address,
    }

    public fun add_allowed_coin<T0>(arg0: &AdminCap, arg1: &Version, arg2: &mut AllowedDonationCoins) {
        checkVersion(arg1, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg2.id, v0), 9223373050467057665);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg2.allowed_coins, v0, true);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0, 0x2::balance::zero<T0>());
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 9223374618131562519);
    }

    public fun disable_allowed_coin<T0>(arg0: &AdminCap, arg1: &Version, arg2: &mut AllowedDonationCoins) {
        checkVersion(arg1, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg2.allowed_coins, v0) == true, 9223373183612092433);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg2.allowed_coins, v0) = false;
    }

    public fun donate<T0>(arg0: &Version, arg1: &mut UserComicRegistry, arg2: &AllowedDonationCoins, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : DonateComicData<T0> {
        checkVersion(arg0, 1);
        assert!(is_coin_allowed<T0>(arg2), 9223374493576855565);
        assert!(arg1.comic_read, 9223374497871560713);
        assert!(arg1.comic_unique_id == arg3, 9223374506461233157);
        let v0 = 0x2::coin::value<T0>(&arg5);
        arg1.total_donated_value = arg1.total_donated_value + v0;
        let v1 = DonateComicData<T0>{
            id             : 0x2::object::new(arg6),
            comic_language : arg4,
            donation       : 0x2::coin::into_balance<T0>(arg5),
        };
        let v2 = DonateComicEvent{
            comic_unique_id          : arg3,
            donate_comic_data_id     : 0x2::object::id<DonateComicData<T0>>(&v1),
            allowed_donation_coin_id : 0x2::object::id<AllowedDonationCoins>(arg2),
            language                 : arg4,
            donation_amount          : v0,
            donor                    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DonateComicEvent>(v2);
        v1
    }

    public fun enable_allowed_coin<T0>(arg0: &AdminCap, arg1: &Version, arg2: &mut AllowedDonationCoins) {
        checkVersion(arg1, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg2.allowed_coins, v0) == false, 9223373127777386511);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg2.allowed_coins, v0) = true;
    }

    public fun get_page_read_count(arg0: &ParentComic, arg1: 0x1::string::String, arg2: address) : u64 {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 9223374691146137625);
        let v0 = 0x2::dynamic_object_field::borrow<0x1::string::String, Comic>(&arg0.id, arg1);
        assert!(0x2::table::contains<address, u64>(&v0.users_read_page_count, arg2), 9223374699736334365);
        *0x2::table::borrow<address, u64>(&v0.users_read_page_count, arg2)
    }

    fun init(arg0: COMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COMIC>(arg0, arg1);
        let v1 = 0x2::display::new<UserComicRegistry>(&v0, arg1);
        0x2::display::add<UserComicRegistry>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Comic Registry"));
        0x2::display::add<UserComicRegistry>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This is user's comic registry which stored comic subscription info."));
        0x2::display::add<UserComicRegistry>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<UserComicRegistry>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<UserComicRegistry>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        let v4 = AllowedDonationCoins{
            id            : 0x2::object::new(arg1),
            allowed_coins : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<AllowedDonationCoins>(v4);
        0x2::transfer::share_object<Version>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_coin_allowed<T0>(arg0: &AllowedDonationCoins) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coins, v0) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.allowed_coins, v0)
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 9223372947389284375);
        arg1.version = arg2;
    }

    public fun mint_child_comic(arg0: &AdminCap, arg1: &Version, arg2: &mut ParentComic, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: 0x1::option::Option<address>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg2.id, arg7), 9223373342525489163);
        let v0 = Comic{
            id                            : 0x2::object::new(arg8),
            name                          : arg3,
            description                   : arg4,
            blob_id                       : arg5,
            charity_address               : arg6,
            total_donation                : 0,
            donations_after_last_withdraw : 0x2::table::new<0x1::type_name::TypeName, u64>(arg8),
            admin                         : 0x2::tx_context::sender(arg8),
            subscribed_by                 : 0,
            language                      : arg7,
            users_read_page_count         : 0x2::table::new<address, u64>(arg8),
        };
        let v1 = ChildComicMintEvent{
            child_comic_id  : 0x2::object::id<Comic>(&v0),
            name            : arg3,
            description     : arg4,
            blob_id         : arg5,
            charity_address : arg6,
            admin           : 0x2::tx_context::sender(arg8),
            language        : arg7,
        };
        0x2::event::emit<ChildComicMintEvent>(v1);
        0x2::dynamic_object_field::add<0x1::string::String, Comic>(&mut arg2.id, arg7, v0);
    }

    public fun mint_parent_comic(arg0: &AdminCap, arg1: &Version, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        let v0 = ParentComic{
            id                 : 0x2::object::new(arg3),
            comic_unique_id    : arg2,
            available_donation : 0,
            total_reads        : 0,
        };
        let v1 = ParentComicMintEvent{
            parent_comic_id : 0x2::object::id<ParentComic>(&v0),
            comic_unique_id : arg2,
        };
        0x2::event::emit<ParentComicMintEvent>(v1);
        0x2::transfer::share_object<ParentComic>(v0);
    }

    public fun mint_registry_mint_cap(arg0: &AdminCap, arg1: &Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        let v0 = RegistryMintCap{id: 0x2::object::new(arg3)};
        let v1 = RegistryMintCapEvent{
            registry_mint_cap_id : 0x2::object::id<RegistryMintCap>(&v0),
            recipient            : arg2,
        };
        0x2::event::emit<RegistryMintCapEvent>(v1);
        0x2::transfer::transfer<RegistryMintCap>(v0, arg2);
    }

    public fun mint_user_comic_registry(arg0: &RegistryMintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &Version, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg4, 1);
        let v0 = UserComicRegistry{
            id                  : 0x2::object::new(arg6),
            comic_unique_id     : arg2,
            total_donated_value : 0,
            image_url           : arg1,
            language            : arg3,
            comic_read          : false,
        };
        let v1 = UserRegistryMintEvent{
            registry_id : 0x2::object::id<UserComicRegistry>(&v0),
            user        : arg5,
        };
        0x2::event::emit<UserRegistryMintEvent>(v1);
        0x2::transfer::transfer<UserComicRegistry>(v0, arg5);
    }

    public fun read_comic(arg0: &Version, arg1: &mut UserComicRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : ReadComicData {
        checkVersion(arg0, 1);
        assert!(!arg1.comic_read, 9223374351842279427);
        assert!(arg1.comic_unique_id == arg2, 9223374360432345093);
        arg1.comic_read = true;
        let v0 = ReadComicData{
            id             : 0x2::object::new(arg4),
            comic_language : arg3,
        };
        let v1 = ReadComicEvent{
            comic_unique_id    : arg2,
            read_comic_data_id : 0x2::object::id<ReadComicData>(&v0),
            language           : arg3,
            reader             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ReadComicEvent>(v1);
        v0
    }

    public fun receive_donate_comic_data<T0>(arg0: &AdminCap, arg1: &Version, arg2: &mut AllowedDonationCoins, arg3: &mut ParentComic, arg4: 0x2::transfer::Receiving<DonateComicData<T0>>) {
        checkVersion(arg1, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::transfer::public_receive<DonateComicData<T0>>(&mut arg3.id, arg4);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Comic>(&mut arg3.id, v1.comic_language);
        let DonateComicData {
            id             : v3,
            comic_language : v4,
            donation       : v5,
        } = v1;
        let v6 = v5;
        let v7 = 0x2::balance::value<T0>(&v6);
        v2.total_donation = v2.total_donation + v7;
        arg3.available_donation = arg3.available_donation + v7;
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&v2.donations_after_last_withdraw, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v2.donations_after_last_withdraw, v0, v7);
        } else {
            let v8 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut v2.donations_after_last_withdraw, v0);
            *v8 = *v8 + v7;
        };
        let v9 = ReceiveDonateComicDataEvent{
            parent_comic_id : 0x2::object::id<ParentComic>(arg3),
            language        : v4,
            received_amount : v7,
        };
        0x2::event::emit<ReceiveDonateComicDataEvent>(v9);
        0x2::object::delete(v3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0), v6);
    }

    public fun receive_read_comic_data(arg0: &AdminCap, arg1: &Version, arg2: &mut ParentComic, arg3: 0x2::transfer::Receiving<ReadComicData>) {
        checkVersion(arg1, 1);
        let v0 = 0x2::transfer::public_receive<ReadComicData>(&mut arg2.id, arg3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Comic>(&mut arg2.id, v0.comic_language);
        let ReadComicData {
            id             : v2,
            comic_language : v3,
        } = v0;
        v1.subscribed_by = v1.subscribed_by + 1;
        arg2.total_reads = arg2.total_reads + 1;
        let v4 = ReceiveReadComicDataEvent{
            parent_comic_id : 0x2::object::id<ParentComic>(arg2),
            language        : v3,
        };
        0x2::event::emit<ReceiveReadComicDataEvent>(v4);
        0x2::object::delete(v2);
    }

    public fun update_comic_blob_id(arg0: &AdminCap, arg1: &Version, arg2: &mut ParentComic, arg3: vector<0x1::string::String>, arg4: 0x1::string::String) {
        checkVersion(arg1, 1);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg2.id, arg4), 9223373514325098521);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Comic>(&mut arg2.id, arg4).blob_id = arg3;
    }

    public fun update_comic_charity_address(arg0: &AdminCap, arg1: &Version, arg2: &mut ParentComic, arg3: 0x1::option::Option<address>, arg4: 0x1::string::String) {
        checkVersion(arg1, 1);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg2.id, arg4), 9223373578749607961);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Comic>(&mut arg2.id, arg4).charity_address = arg3;
    }

    public fun update_user_read_page_count(arg0: &AdminCap, arg1: &Version, arg2: &mut ParentComic, arg3: 0x1::string::String, arg4: address, arg5: u64) {
        checkVersion(arg1, 1);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg2.id, arg3), 9223373647469084697);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Comic>(&mut arg2.id, arg3);
        if (!0x2::table::contains<address, u64>(&v0.users_read_page_count, arg4)) {
            0x2::table::add<address, u64>(&mut v0.users_read_page_count, arg4, arg5);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut v0.users_read_page_count, arg4) = arg5;
        };
    }

    public fun withdraw_donation<T0>(arg0: &AdminCap, arg1: &Version, arg2: &mut AllowedDonationCoins, arg3: &mut ParentComic, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg3.available_donation > 0, 9223373875101171719);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Comic>(&mut arg3.id, arg4);
        assert!(0x1::option::is_some<address>(&v1.charity_address), 9223373887987384347);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&v1.donations_after_last_withdraw, v0), 9223373892281958421);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut v1.donations_after_last_withdraw, v0);
        assert!(*v2 > 0, 9223373900871761939);
        let v3 = 0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0), *v2, arg5);
        arg3.available_donation = arg3.available_donation - 0x2::coin::value<T0>(&v3);
        *v2 = 0;
        let v4 = WithdrawDonationEvent{
            child_comic_id           : 0x2::object::id<Comic>(v1),
            receiving_comic_language : arg4,
            withdraw_coin_type       : v0,
            amount                   : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<WithdrawDonationEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, *0x1::option::borrow<address>(&v1.charity_address));
    }

    // decompiled from Move bytecode v6
}

