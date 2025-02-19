module 0xed9b69ec3ab8ccf4dbf62da2f0838dc48cf508274917063cecc5213b6781aaa7::plr {
    struct PLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLR>(arg0, 9, b"PLR", b"PLAPPER", b"JUST THE PLANE PAPPER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50c6b809-ad47-4424-8e71-5d46fe0171ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

