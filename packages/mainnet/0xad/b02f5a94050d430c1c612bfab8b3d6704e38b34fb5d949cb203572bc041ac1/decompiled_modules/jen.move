module 0xadb02f5a94050d430c1c612bfab8b3d6704e38b34fb5d949cb203572bc041ac1::jen {
    struct JEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEN>(arg0, 6, b"JEN", b"Jensen Huang", b"A pixel-style meme coin paying tribute to Jensen Huang  the legendary leather-jacketed CEO of NVIDIA. This token celebrates GPUs, AI, and meme culture with style and humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_c_e_2025_05_02_014833_8ce316ae88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

