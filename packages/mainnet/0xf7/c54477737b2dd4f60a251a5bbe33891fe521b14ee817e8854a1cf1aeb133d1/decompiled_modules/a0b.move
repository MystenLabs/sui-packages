module 0xf7c54477737b2dd4f60a251a5bbe33891fe521b14ee817e8854a1cf1aeb133d1::a0b {
    struct A0B has drop {
        dummy_field: bool,
    }

    fun init(arg0: A0B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A0B>(arg0, 9, b"A0B", b"ay0ub", b"This is the first ever meme coin on memedexx!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.recrd.com/discover?post_id=cf842890-fe01-11ec-bd17-c1d8dfc65762&ref=ed203220-3627-11f0-8ed8-bfb2130e5108")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<A0B>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A0B>>(v2, @0xcd77bc1e00ce9b6eb15bbd89d7e4521330c5fa8a170da7d12081a1d0b003a95);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A0B>>(v1);
    }

    // decompiled from Move bytecode v6
}

