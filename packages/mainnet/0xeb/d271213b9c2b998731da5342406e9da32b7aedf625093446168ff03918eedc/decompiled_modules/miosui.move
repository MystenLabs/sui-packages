module 0xebd271213b9c2b998731da5342406e9da32b7aedf625093446168ff03918eedc::miosui {
    struct MIOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOSUI>(arg0, 6, b"MIOSUI", b"MIOCAT SUI", b"MioSui is a lucky cat in the crypto world. Its mission is to bring wealth and prosperity to everyone. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ptichka_500_500_px_8_a0d3a8629c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

