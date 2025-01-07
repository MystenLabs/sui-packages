module 0x23e82c5098802e680e8a9d435dca17dd31493fee4031977fd8d9d6bb642c0908::notpixel {
    struct NOTPIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTPIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTPIXEL>(arg0, 9, b"NOTPIXEL", b"$PX", b"No ads, no promo, not even a coin. Only inquisitive Pixels. Visionaries. Delight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/942b36a9-84c1-4b23-92cf-495a7c9d2d1b-1000381172.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTPIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTPIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

