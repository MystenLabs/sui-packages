module 0xcd3a9671c2f552b5afaf23957024ce778d17e441045bfa5d8661ee58961acb57::paca {
    struct PACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACA>(arg0, 6, b"PACA", b"ALPACA", b"ALPACA , He's dumb, degen, and proud of it. ALPACA doesnt overthink, he just jumps into the craziest trades without a second thought.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500_X500_181be2fd99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

