module 0xe2bac9ecc1b8d5bff9c76ac4eca76fc3da33b0762f6259853de383c6f00f8765::crb {
    struct CRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRB>(arg0, 6, b"CRB", b"CHILL RABBIT", b"Chill Rabbit is a meme of a rabbit caught chilling in its hole making everyone entertained, this meme will be launched on the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0710_a6f0a3fecd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

