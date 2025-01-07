module 0x8e75ab5bf566203fa4a868f1a7c603a07c6eaa02f99578e489ca3c6f524c4283::fudgang {
    struct FUDGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGANG>(arg0, 6, b"FUDGANG", b"FuddiesGang", b"AI NFT Collection & Meme coin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_4_b0be173ba6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

