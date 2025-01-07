module 0x7af0d61872bf6c0d340273da2c2d474d94487fdeb562ca23847c72303aa7c14e::DOGY {
    struct DOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGY>(arg0, 9, b"DOGY", b"DOGY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGY>>(0x2::coin::mint<DOGY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

