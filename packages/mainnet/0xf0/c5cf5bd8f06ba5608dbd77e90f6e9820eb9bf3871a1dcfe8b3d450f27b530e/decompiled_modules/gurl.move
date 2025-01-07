module 0xf0c5cf5bd8f06ba5608dbd77e90f6e9820eb9bf3871a1dcfe8b3d450f27b530e::gurl {
    struct GURL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURL>(arg0, 6, b"GURL", b"Gurl", b"Just a random gurl. Ahh Gurls.. Come on we all love gurls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_139c3b9c0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURL>>(v1);
    }

    // decompiled from Move bytecode v6
}

