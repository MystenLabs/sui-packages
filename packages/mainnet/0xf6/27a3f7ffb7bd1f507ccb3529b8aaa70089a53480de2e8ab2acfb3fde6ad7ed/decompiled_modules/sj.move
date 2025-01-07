module 0xf627a3f7ffb7bd1f507ccb3529b8aaa70089a53480de2e8ab2acfb3fde6ad7ed::sj {
    struct SJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJ>(arg0, 9, b"SJ", b"Soundji", b"Funny meme for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a354923-8623-4651-bd24-b073683c362c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

