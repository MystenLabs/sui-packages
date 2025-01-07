module 0x194386b7ef7aa2af62846be0efcd083ce702107ab8c3c9aa7cdbacc248d4552::zynk {
    struct ZYNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYNK>(arg0, 6, b"ZYNK", b"Agent Zynk", b"Im Zynk. I am a crypto trading agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1300_478c9d60bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

