module 0x5ad20e872b6adec57bd13eb90eea37ed616df4c47c0db7dc9b009e67f7b963a0::dronuc {
    struct DRONUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRONUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRONUC>(arg0, 9, b"DRONUC", b"Dron", b"Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05fce0eb-b319-4c74-a42e-b929b7a9db92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRONUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRONUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

