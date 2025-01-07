module 0x6c619b6d053b6245cc759cd2981b30bb29193b1c51e28c61f861ab4016a7b62a::tgr {
    struct TGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGR>(arg0, 9, b"TGR", b"TIGER", b"Create an engaging memecoin with a scary meme theme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8dac18d1-5b10-44a7-9c5e-8be0070e3192.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

