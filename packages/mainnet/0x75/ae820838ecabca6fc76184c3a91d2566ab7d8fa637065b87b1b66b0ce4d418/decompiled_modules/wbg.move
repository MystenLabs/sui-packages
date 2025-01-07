module 0x75ae820838ecabca6fc76184c3a91d2566ab7d8fa637065b87b1b66b0ce4d418::wbg {
    struct WBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBG>(arg0, 9, b"WBG", b"WeiboGamin", b"Weibo Gaming is a Chinese esports organization owned by Chinese social media platform Weibo, which acquired the LPL team Suning on November 22nd, 2021.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cb76de7-e5f1-45ae-b9a1-efc044b29cd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

