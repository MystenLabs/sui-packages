module 0xf33b39267b6bd4c0f9ca34cde12ae8b93b11b97877fc4b5e7f2b9a9ccd884e4b::tengou {
    struct TENGOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENGOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENGOU>(arg0, 6, b"TENGOU", b"TIANGOU MEME", b"$TENGOU, protecting gates of heaven Since 770 BC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9533_9cbbb4596d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENGOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENGOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

