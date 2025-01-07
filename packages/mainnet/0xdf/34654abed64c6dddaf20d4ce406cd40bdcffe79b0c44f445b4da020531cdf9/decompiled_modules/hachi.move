module 0xdf34654abed64c6dddaf20d4ce406cd40bdcffe79b0c44f445b4da020531cdf9::hachi {
    struct HACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHI>(arg0, 9, b"HACHI", b"Hachi", b"Discover the legend of Hachi, renowned as the epitome of Loyalty, as his unwavering devotion extends into the digital realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0194cf8f-4515-46cf-9df2-169662acc2bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

