module 0xc08051fe853490fd5016d60249f28d37342f891127aa73bb78fc7679b9b6418d::ppy {
    struct PPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPY>(arg0, 6, b"PPY", b"opportunitymeme", b"$PPY is a meme coin with no intrinsic value or expectation of financial return. There is no official team or roadmap. And only used for the purpose of commemorating the great contribution to ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730812401072.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

