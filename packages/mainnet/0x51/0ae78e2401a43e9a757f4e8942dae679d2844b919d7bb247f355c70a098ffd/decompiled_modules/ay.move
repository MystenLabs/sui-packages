module 0x510ae78e2401a43e9a757f4e8942dae679d2844b919d7bb247f355c70a098ffd::ay {
    struct AY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AY>(arg0, 9, b"AY", b"AlYur", b"https://x.com/AlYur777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5bc628f3f3cd403a99cf36483636cda3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

