module 0xf01d506f64e966e667f1fca9b6891bf501a514033449e1eb39a65b0ba40d8bbb::shaobing {
    struct SHAOBING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAOBING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAOBING>(arg0, 6, b"SHAOBING", b"Its just a puppy cat SHAOBING", b"Meet Shaobing Its just a puppy cat a cute ginger puppy cat has gained a lot of attention on TikTok, gaining over 4m+ views on TikTok in less than three days.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2_631ae6e54a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAOBING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAOBING>>(v1);
    }

    // decompiled from Move bytecode v6
}

