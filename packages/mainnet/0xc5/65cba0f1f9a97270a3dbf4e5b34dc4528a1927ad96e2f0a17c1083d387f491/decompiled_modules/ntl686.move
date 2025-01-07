module 0xc565cba0f1f9a97270a3dbf4e5b34dc4528a1927ad96e2f0a17c1083d387f491::ntl686 {
    struct NTL686 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTL686, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTL686>(arg0, 9, b"NTL686", b"Dragon ", b"when whales fly i like it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/428bb293-21f8-4838-8dfe-55324e092086.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTL686>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTL686>>(v1);
    }

    // decompiled from Move bytecode v6
}

