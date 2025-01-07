module 0x12cdb0cfa7e88b1d040f4f14079a8b06f5e3066ad9af2390e944cefdd9aa9d23::japanac {
    struct HACA has drop {
        dummy_field: bool,
    }

    struct JAPANAC has drop {
        dummy_field: bool,
    }

    struct ContractState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HACA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext, arg4: &ContractState) {
        assert!(!arg4.is_paused, 9223372221538369535);
        0x2::transfer::public_transfer<0x2::coin::Coin<HACA>>(0x2::coin::mint<HACA>(arg0, arg1, arg3), arg2);
    }

    public fun assert_admin(arg0: &AdminCapability) {
        assert!(is_admin(arg0), 9223372401926995967);
    }

    public fun burn_tokens(arg0: &mut 0x2::coin::TreasuryCap<HACA>, arg1: 0x2::coin::Coin<HACA>) {
        0x2::coin::burn<HACA>(arg0, arg1);
    }

    fun init(arg0: JAPANAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAPANAC>(arg0, 9, b"HACA", b"HACA", b"https://i.postimg.cc/qRyVm2HW/HACA.png", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAPANAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<JAPANAC>>(0x2::coin::mint<JAPANAC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAPANAC>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun is_admin(arg0: &AdminCapability) : bool {
        true
    }

    public fun pause(arg0: &AdminCapability, arg1: &mut ContractState) {
        assert!(is_admin(arg0), 9223372307437715455);
        arg1.is_paused = true;
    }

    public fun unpause(arg0: &AdminCapability, arg1: &mut ContractState) {
        assert!(is_admin(arg0), 9223372333207519231);
        arg1.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

