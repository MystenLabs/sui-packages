module 0x60ec676ef01e45c5d07307d64eb65369b60523b800211b6a80a21e625f37a47f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"SUIPUMP", b"SuiPump", b"SUIPUMP Coin is a Meme coin, SUIPUMP released First on SUI blockchain with inspiration and main image from the SUIPUMP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5da966c1-2a99-463e-9042-31a42bc3d568.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

