module 0x82635f15d0ebdd6be35cb17bf8142adae0f1b6aa753c403824c82cdda4dd7f5a::serpentum {
    struct SERPENTUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERPENTUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERPENTUM>(arg0, 6, b"Serpentum", b"Serpentum on sui", b"Pulse ON SUI community today and be part of the next wave of meme token success on the SUI blockchain. Get ready for a journey full of laughter, innovation, and opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_3e0529e3d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERPENTUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERPENTUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

