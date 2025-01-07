module 0x3052770dfc065c963a0618fd8ca8183cca8ec2ad306db59fe0126060aa880d69::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILLA>(arg0, 9, b"ZILLA", b"Zilla On Sui", b"Zilla Is Meme On Sui chain , LFG !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845507095015432193/qgpcqHsr.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZILLA>(&mut v2, 665000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

