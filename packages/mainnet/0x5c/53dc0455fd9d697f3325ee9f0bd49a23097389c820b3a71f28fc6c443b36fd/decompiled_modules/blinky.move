module 0x5c53dc0455fd9d697f3325ee9f0bd49a23097389c820b3a71f28fc6c443b36fd::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"Blinky on Sui", b"www.blinkysui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111111_89e636e28c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

