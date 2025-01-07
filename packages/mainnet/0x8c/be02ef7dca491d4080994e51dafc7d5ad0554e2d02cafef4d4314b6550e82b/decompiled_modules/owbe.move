module 0x8cbe02ef7dca491d4080994e51dafc7d5ad0554e2d02cafef4d4314b6550e82b::owbe {
    struct OWBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWBE>(arg0, 9, b"OWBE", b"bdjd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9afd5793-dd94-4ea2-9d23-2287b2976c2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

