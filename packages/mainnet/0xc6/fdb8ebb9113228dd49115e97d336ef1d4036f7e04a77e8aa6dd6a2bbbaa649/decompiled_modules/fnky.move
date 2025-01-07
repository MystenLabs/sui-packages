module 0xc6fdb8ebb9113228dd49115e97d336ef1d4036f7e04a77e8aa6dd6a2bbbaa649::fnky {
    struct FNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNKY>(arg0, 9, b"FNKY", b"FUNKY", b"JUST MEME FOR US. LETS MAKE FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d3dbac0-3c12-4c77-be03-de3a03e2087a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

