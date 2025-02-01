module 0xd85e054d954f0125c1695431eee5fa5c69878ec8d2c3586f18f32dd6c337025f::romacis {
    struct ROMACIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMACIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMACIS>(arg0, 9, b"ROMACIS", b"romabis", b"the new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e92ba9a-ed04-465d-87bc-c5709138b1c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMACIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROMACIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

