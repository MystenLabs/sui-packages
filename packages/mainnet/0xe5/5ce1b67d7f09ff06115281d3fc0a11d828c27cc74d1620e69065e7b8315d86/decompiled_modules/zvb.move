module 0xe55ce1b67d7f09ff06115281d3fc0a11d828c27cc74d1620e69065e7b8315d86::zvb {
    struct ZVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZVB>(arg0, 6, b"ZVB", b"ZVB", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZVB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZVB>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZVB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

