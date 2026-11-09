module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip_page {
    struct TipPage has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        avatar: 0x1::string::String,
        art: 0x1::string::String,
        card: 0x1::string::String,
        amounts: vector<u64>,
        coins: vector<0x1::ascii::String>,
        version: u64,
    }

    struct TipPageCreated has copy, drop {
        page: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        paid: u64,
    }

    struct TipPageUpdated has copy, drop {
        page: 0x2::object::ID,
        owner: address,
        version: u64,
    }

    struct HeadlineKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AcceptAnyKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun accepts_any(arg0: &TipPage) : bool {
        let v0 = AcceptAnyKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AcceptAnyKey>(&arg0.id, v0)) {
            let v2 = AcceptAnyKey{dummy_field: false};
            *0x2::dynamic_field::borrow<AcceptAnyKey, bool>(&arg0.id, v2)
        } else {
            true
        }
    }

    public fun amounts(arg0: &TipPage) : vector<u64> {
        arg0.amounts
    }

    public fun art(arg0: &TipPage) : 0x1::string::String {
        arg0.art
    }

    public fun avatar(arg0: &TipPage) : 0x1::string::String {
        arg0.avatar
    }

    fun build(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u64>, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) : TipPage {
        let v0 = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(0x2::tx_context::sender(arg8))) {
            0
        } else {
            0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::page_price(arg0)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v0, 1);
        check(&arg2, &arg3, &arg4, &arg5, &arg6, &arg7);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::fee_recipient(arg0));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        mint(v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun card(arg0: &TipPage) : 0x1::string::String {
        arg0.card
    }

    fun check(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<u64>, arg5: &vector<0x1::ascii::String>) {
        assert!(is_clean_name(arg0), 3);
        let v0 = if (ok_blob(arg1)) {
            if (ok_blob(arg2)) {
                ok_blob(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(0x1::vector::length<u64>(arg4) <= 4, 5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg4)) {
            assert!(*0x1::vector::borrow<u64>(arg4, v1) > 0, 5);
            v1 = v1 + 1;
        };
        assert!(0x1::vector::length<0x1::ascii::String>(arg5) <= 4, 6);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(arg5)) {
            let v3 = 0x1::ascii::length(0x1::vector::borrow<0x1::ascii::String>(arg5, v2));
            assert!(v3 > 0 && v3 <= 256, 6);
            v2 = v2 + 1;
        };
    }

    public fun coins(arg0: &TipPage) : vector<0x1::ascii::String> {
        arg0.coins
    }

    public fun create(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u64>, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg0);
        let v0 = build(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::share_object<TipPage>(v0);
        0x2::object::id<TipPage>(&v0)
    }

    public fun create_credited<T0: drop>(arg0: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u64>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg0);
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::use_credit<T0>(arg0, 0x2::tx_context::sender(arg9));
        check(&arg2, &arg4, &arg5, &arg6, &arg7, &arg8);
        let v0 = mint(0, arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = &mut v0;
        set_hl(v1, arg3);
        0x2::transfer::share_object<TipPage>(v0);
        0x2::object::id<TipPage>(&v0)
    }

    public fun create_v2(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u64>, arg8: vector<0x1::ascii::String>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip::assert_version(arg0);
        let v0 = build(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = &mut v0;
        set_hl(v1, arg3);
        0x2::transfer::share_object<TipPage>(v0);
        0x2::object::id<TipPage>(&v0)
    }

    public fun headline(arg0: &TipPage) : 0x1::string::String {
        let v0 = HeadlineKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HeadlineKey>(&arg0.id, v0)) {
            let v2 = HeadlineKey{dummy_field: false};
            *0x2::dynamic_field::borrow<HeadlineKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            0x1::string::utf8(b"")
        }
    }

    public fun is_clean_headline(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 > 160) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (v3 < 32 || v3 == 127) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun is_clean_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 128) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (v3 < 32 || v3 == 127) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun mint(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u64>, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) : TipPage {
        let v0 = TipPage{
            id      : 0x2::object::new(arg7),
            owner   : 0x2::tx_context::sender(arg7),
            name    : arg1,
            avatar  : arg2,
            art     : arg3,
            card    : arg4,
            amounts : arg5,
            coins   : arg6,
            version : 0,
        };
        let v1 = TipPageCreated{
            page  : 0x2::object::id<TipPage>(&v0),
            owner : 0x2::tx_context::sender(arg7),
            name  : v0.name,
            paid  : arg0,
        };
        0x2::event::emit<TipPageCreated>(v1);
        v0
    }

    public fun name(arg0: &TipPage) : 0x1::string::String {
        arg0.name
    }

    fun ok_blob(arg0: &0x1::string::String) : bool {
        0x1::string::length(arg0) == 0 || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_blob_id(arg0)
    }

    public fun owner(arg0: &TipPage) : address {
        arg0.owner
    }

    public fun set_accept_any(arg0: &mut TipPage, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let v0 = AcceptAnyKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AcceptAnyKey>(&arg0.id, v0)) {
            let v1 = AcceptAnyKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<AcceptAnyKey, bool>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = AcceptAnyKey{dummy_field: false};
            0x2::dynamic_field::add<AcceptAnyKey, bool>(&mut arg0.id, v2, arg1);
        };
        arg0.version = arg0.version + 1;
        let v3 = TipPageUpdated{
            page    : 0x2::object::id<TipPage>(arg0),
            owner   : arg0.owner,
            version : arg0.version,
        };
        0x2::event::emit<TipPageUpdated>(v3);
    }

    fun set_hl(arg0: &mut TipPage, arg1: 0x1::string::String) {
        assert!(is_clean_headline(&arg1), 7);
        let v0 = HeadlineKey{dummy_field: false};
        if (0x1::string::length(&arg1) == 0) {
            if (0x2::dynamic_field::exists<HeadlineKey>(&arg0.id, v0)) {
                let v1 = HeadlineKey{dummy_field: false};
                0x2::dynamic_field::remove<HeadlineKey, 0x1::string::String>(&mut arg0.id, v1);
            };
        } else if (0x2::dynamic_field::exists<HeadlineKey>(&arg0.id, v0)) {
            let v2 = HeadlineKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<HeadlineKey, 0x1::string::String>(&mut arg0.id, v2) = arg1;
        } else {
            let v3 = HeadlineKey{dummy_field: false};
            0x2::dynamic_field::add<HeadlineKey, 0x1::string::String>(&mut arg0.id, v3, arg1);
        };
    }

    public fun set_owner(arg0: &mut TipPage, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.owner = arg1;
        arg0.version = arg0.version + 1;
        let v0 = TipPageUpdated{
            page    : 0x2::object::id<TipPage>(arg0),
            owner   : arg1,
            version : arg0.version,
        };
        0x2::event::emit<TipPageUpdated>(v0);
    }

    public fun update(arg0: &mut TipPage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u64>, arg6: vector<0x1::ascii::String>, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 2);
        check(&arg1, &arg2, &arg3, &arg4, &arg5, &arg6);
        arg0.name = arg1;
        arg0.avatar = arg2;
        arg0.art = arg3;
        arg0.card = arg4;
        arg0.amounts = arg5;
        arg0.coins = arg6;
        arg0.version = arg0.version + 1;
        let v0 = TipPageUpdated{
            page    : 0x2::object::id<TipPage>(arg0),
            owner   : arg0.owner,
            version : arg0.version,
        };
        0x2::event::emit<TipPageUpdated>(v0);
    }

    public fun update_v2(arg0: &mut TipPage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u64>, arg7: vector<0x1::ascii::String>, arg8: &0x2::tx_context::TxContext) {
        assert!(is_clean_headline(&arg2), 7);
        update(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
        set_hl(arg0, arg2);
    }

    public fun version(arg0: &TipPage) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

