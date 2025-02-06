module 0x945d467e72c495a8d5550a2d2f3e67ac6bb20c3ef68080d5f792a3e19f29d65b::monke {
    struct MONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKE>(arg0, 6, b"MONKE", b"MONKE ON SUI", b"MONKErides the wave of the meme coin revolution, harnessing the speed, scalability, and low fees of the SUI network. While tokens likeMONKEcan see wild price swings, they draw in risk-takers and degens eager to seize short-term opportunities in the ever-evolving crypto jungle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001628_a22094116c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

