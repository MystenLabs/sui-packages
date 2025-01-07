module 0x882a87dcbea2c1365a48b3bac7a43c6cbeac09234d40e974b2c27e0ca30b3df8::dreg {
    struct DREG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREG>(arg0, 6, b"DREG", b"SUI DREG", b"Fun meme, a combination between Frog and Doge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dreg_logo2_9a7e5257d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREG>>(v1);
    }

    // decompiled from Move bytecode v6
}

