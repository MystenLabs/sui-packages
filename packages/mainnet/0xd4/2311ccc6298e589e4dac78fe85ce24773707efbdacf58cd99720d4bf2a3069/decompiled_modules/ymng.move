module 0xd42311ccc6298e589e4dac78fe85ce24773707efbdacf58cd99720d4bf2a3069::ymng {
    struct YMNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YMNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YMNG>(arg0, 9, b"YMNG", b"YaoMing", b"This is a meme about my favorite basketball player", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e7674e1-0fd5-4ec1-acb9-7b1206cae8e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YMNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YMNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

