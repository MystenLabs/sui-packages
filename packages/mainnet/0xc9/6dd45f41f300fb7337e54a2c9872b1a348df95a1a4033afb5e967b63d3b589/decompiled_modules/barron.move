module 0xc96dd45f41f300fb7337e54a2c9872b1a348df95a1a4033afb5e967b63d3b589::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"BARRON", b"Barron trump", b"Barron", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trolltastic_com_cde0f2bf6b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

