module 0x9a78ea8b4656d9a7c75051a5bd128712cbeceb377b6c1519322bec695fbbec0c::wwp {
    struct WWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWP>(arg0, 9, b"WWP", b"WEWEPUMPP", b"WEWEPUMP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed363edb-932a-424a-b7e3-42ceb079f0e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

