module 0x4198f18420f13bff30fa08e449738aa684f1b954a37f70a6eb3b305c67f76183::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 6, b"STITCH", b"Stitch", b"Stitch, also known as Experiment 626 (pronounced \"six two six\"), is a fictional character from Disney's Lilo & Stitch franchise. A genetically engineered, extraterrestrial life-form resembling a blue koala, he is the more prominent of the franchise's two title protagonists, the other being his human adopter and best friend Lilo Pelekai.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/202481093327_1_689e30fc9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

