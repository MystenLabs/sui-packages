module 0xeb702c3a5faedcf8cf262ceccd3aab731f5403557e49fdef83c88b0499f3205a::plt {
    struct PLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLT>(arg0, 9, b"PLT", b"PLANET", b"MAGICAL PLANETS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6acaf6a-dc83-497e-8517-079d4fddea54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

