module 0x39e28eed9db863aae48c5f2c2605a782a64ca13633fb1a50459cca2105a59aae::ktt {
    struct KTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTT>(arg0, 9, b"KTT", b"kitten", b"to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f158bb34-f2d3-4c56-8b36-ecad09af8826.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

