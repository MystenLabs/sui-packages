module 0xb180d50ecf3e9234beb339a640e6050bd8ba920fb60109b4a576d2e7090ab6b9::korsui {
    struct KORSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORSUI>(arg0, 6, b"KORSUI", b"$KORSUI", b"The $KORSUI sticker suddenly appeared on Telegram and quickly became a sensation. With its cute images and funny expressions, this sticker became the new \"trend\" in conversations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KORSUI_f804c4b4f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

