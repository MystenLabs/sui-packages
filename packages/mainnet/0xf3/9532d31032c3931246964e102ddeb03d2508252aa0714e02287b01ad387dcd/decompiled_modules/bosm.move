module 0xf39532d31032c3931246964e102ddeb03d2508252aa0714e02287b01ad387dcd::bosm {
    struct BOSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSM>(arg0, 9, b"BOSM", b"BookOfSuiMemes", b"BookOfSuiMemes is a catchy and playful name, blending crypto with meme culture. It hints at a fun \"legendary\" collection of Sui-related memes, perfect for engaging a community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1196393314682982400/yajcawq1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOSM>(&mut v2, 1200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

