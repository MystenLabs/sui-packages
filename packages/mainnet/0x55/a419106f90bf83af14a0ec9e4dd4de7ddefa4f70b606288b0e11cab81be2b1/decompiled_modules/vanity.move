module 0x55a419106f90bf83af14a0ec9e4dd4de7ddefa4f70b606288b0e11cab81be2b1::vanity {
    struct VANITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANITY>(arg0, 9, b"VANITY", b"Vanity", b"Vanity token deployed via Sui Vanity Token Generator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<VANITY>>(0x2::coin::mint<VANITY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANITY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

