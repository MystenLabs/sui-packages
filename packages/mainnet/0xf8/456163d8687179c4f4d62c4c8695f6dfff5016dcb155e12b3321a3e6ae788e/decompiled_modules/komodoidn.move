module 0xf8456163d8687179c4f4d62c4c8695f6dfff5016dcb155e12b3321a3e6ae788e::komodoidn {
    struct KOMODOIDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMODOIDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMODOIDN>(arg0, 9, b"KOMODOIDN", b"KOMODO", b"KOMODO animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a32b684c-2f9a-447d-bebb-f4bc5008eec6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMODOIDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOMODOIDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

