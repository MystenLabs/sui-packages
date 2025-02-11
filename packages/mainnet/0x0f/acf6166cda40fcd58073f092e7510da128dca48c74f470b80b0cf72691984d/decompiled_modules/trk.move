module 0xfacf6166cda40fcd58073f092e7510da128dca48c74f470b80b0cf72691984d::trk {
    struct TRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRK>(arg0, 9, b"TRK", b"TrekMeme", b"Born from a viral tweet about Captain Kirk's epic space dance battle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739260762/yyfxaipjshzx0ixfkftd.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

