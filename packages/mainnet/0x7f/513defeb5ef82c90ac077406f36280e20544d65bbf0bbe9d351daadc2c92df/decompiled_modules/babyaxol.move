module 0x7f513defeb5ef82c90ac077406f36280e20544d65bbf0bbe9d351daadc2c92df::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYAXOL>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYAXOL>>(0x2::coin::mint<BABYAXOL>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 9, b"AXOL", b"Baby Axol", b"Baby Axol a protege of the major Axol, making splashes gives the chance after missing the major Axol fair launch,SAFU no team allocation coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYAXOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

