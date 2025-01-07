module 0x3c390eb4f7b073c13b5f3635fe6fe9adae6537562bd502e34e399c4ffcae0a8f::xinxin {
    struct XINXIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XINXIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XINXIN>(arg0, 9, b"XINXIN", b"xinxin", b"xinxinpump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e614d20-ad62-4689-8157-532892a84de8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XINXIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XINXIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

