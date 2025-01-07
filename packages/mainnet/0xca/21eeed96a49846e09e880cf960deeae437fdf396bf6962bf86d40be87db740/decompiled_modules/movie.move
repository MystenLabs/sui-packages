module 0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie {
    struct MOVIE has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<MOVIE>) {
        0x2::coin::burn<MOVIE>(borrow_mutable_cap(arg0), arg1);
    }

    public fun total_supply(arg0: &mut ProtectedTreasury) : u64 {
        0x2::coin::total_supply<MOVIE>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<MOVIE> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<MOVIE>>(&arg0.id, v0)
    }

    fun borrow_mutable_cap(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<MOVIE> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<MOVIE>>(&mut arg0.id, v0)
    }

    fun init(arg0: MOVIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVIE>(arg0, 8, b"MOVIE", b"MOVIE", b"The $MOVIE token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://hpsqod2j5cebdx7xg5scuc2utngkgadd27zsylmgrvid3pumvqtq.arweave.net/O-UHD0noiBHf9zdkKgtUm0yjAGPX8ywtho1QPb6MrCc"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVIE>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        0x2::coin::mint_and_transfer<MOVIE>(&mut v2, 12000000000000000000, @0x1a350ef298ce581e13139a6f255f40eb04041b15a3044942aea9537e11e435ec, arg1);
        let v4 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v4, @0x1a350ef298ce581e13139a6f255f40eb04041b15a3044942aea9537e11e435ec);
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<MOVIE>>(&mut v3.id, v5, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
    }

    public entry fun mint(arg0: &MintCap, arg1: &mut ProtectedTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mutable_cap(arg1);
        assert!(0x2::coin::total_supply<MOVIE>(v0) + arg2 * 100000000 <= 12000000000000000000, 5);
        0x2::coin::mint_and_transfer<MOVIE>(v0, arg2 * 100000000, @0x1a350ef298ce581e13139a6f255f40eb04041b15a3044942aea9537e11e435ec, arg3);
    }

    // decompiled from Move bytecode v6
}

