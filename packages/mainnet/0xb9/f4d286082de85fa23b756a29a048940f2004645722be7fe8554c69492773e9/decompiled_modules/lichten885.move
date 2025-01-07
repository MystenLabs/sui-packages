module 0xb9f4d286082de85fa23b756a29a048940f2004645722be7fe8554c69492773e9::lichten885 {
    struct LICHTEN885 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICHTEN885, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICHTEN885>(arg0, 9, b"LICHTEN885", b"LICHTEN", b"LICH TEN FROM DRAGON BALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/289d003f-24ec-4da8-9fd5-85e2ed1071a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICHTEN885>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LICHTEN885>>(v1);
    }

    // decompiled from Move bytecode v6
}

