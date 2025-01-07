module 0xdfde3ce3e0f0d0b38b4b494b8af8c50700b694c71155934a182d7bcbac9ce7c4::gk {
    struct GK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GK>(arg0, 9, b"GK", b"mirali", b"jacobabad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9b6f132-1db1-486c-a7d5-849fc2c08408.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GK>>(v1);
    }

    // decompiled from Move bytecode v6
}

