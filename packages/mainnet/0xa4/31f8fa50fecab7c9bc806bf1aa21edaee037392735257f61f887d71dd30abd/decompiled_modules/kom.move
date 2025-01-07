module 0xa431f8fa50fecab7c9bc806bf1aa21edaee037392735257f61f887d71dd30abd::kom {
    struct KOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOM>(arg0, 6, b"KOM", b"King of meme coin", b"The king of sui meme coin is here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000409015_c6d2f3d9c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

