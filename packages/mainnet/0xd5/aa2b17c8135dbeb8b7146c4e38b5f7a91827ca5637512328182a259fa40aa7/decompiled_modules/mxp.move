module 0xd5aa2b17c8135dbeb8b7146c4e38b5f7a91827ca5637512328182a259fa40aa7::mxp {
    struct MXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXP>(arg0, 9, b"MXP", b"MaxPro", b"Maximum Professional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1373be61-58a4-4fc4-bd10-f74a49145460.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

