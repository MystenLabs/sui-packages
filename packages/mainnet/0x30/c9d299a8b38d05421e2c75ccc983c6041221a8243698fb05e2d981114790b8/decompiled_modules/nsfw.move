module 0x30c9d299a8b38d05421e2c75ccc983c6041221a8243698fb05e2d981114790b8::nsfw {
    struct NSFW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSFW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSFW>(arg0, 6, b"NSFW", b"NotSuitableForWork", x"4e6f74205355497461626c6520466f7220576f726b0a537373756965787878", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7615_34c8a74505.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSFW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSFW>>(v1);
    }

    // decompiled from Move bytecode v6
}

