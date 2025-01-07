module 0x70b14d1fc9b090af2dfe017cfa773bf1f9ea8ab9c2bbb0204610c9a8a67f07da::peneb {
    struct PENEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENEB>(arg0, 9, b"PENEB", b"jknv", b"brbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46d0e060-a2fb-4bce-9765-d59a13f3f880.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

