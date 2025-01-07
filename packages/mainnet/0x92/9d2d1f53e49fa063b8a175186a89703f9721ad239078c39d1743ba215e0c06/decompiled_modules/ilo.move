module 0x929d2d1f53e49fa063b8a175186a89703f9721ad239078c39d1743ba215e0c06::ilo {
    struct ILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILO>(arg0, 9, b"ILO", b"LLOVE", b"OLOOOOOOOOVEEEEEYOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb6e5fcc-1318-4e2a-a7b8-22574319d4ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

