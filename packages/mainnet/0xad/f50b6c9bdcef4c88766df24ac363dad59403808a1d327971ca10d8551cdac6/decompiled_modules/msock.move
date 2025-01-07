module 0xadf50b6c9bdcef4c88766df24ac363dad59403808a1d327971ca10d8551cdac6::msock {
    struct MSOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSOCK>(arg0, 9, b"MSOCK", b"MoonSocks", b" Cozy up to the moon with the comfiest meme coin around.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/102c0582-4762-45b9-b742-3daf54331e5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

