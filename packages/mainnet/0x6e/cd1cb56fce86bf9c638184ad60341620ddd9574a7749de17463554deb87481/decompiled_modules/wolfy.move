module 0x6ecd1cb56fce86bf9c638184ad60341620ddd9574a7749de17463554deb87481::wolfy {
    struct WOLFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFY>(arg0, 6, b"WOLFY", b"WOLFY BITS", b"#WOLFY BITS is not just a #memecoin, it's a whole wolf pack in the #SUI Network world! Forget boring and dull tokens because WOLFY BITS is a real celebration for all meme lovers and crypto enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoround_32436e78f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

