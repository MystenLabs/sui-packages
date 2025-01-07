module 0xa7b0af81fce07528a10c1133e91deafe5edf023e864e335256c243bfdd1ee0d0::cfc {
    struct CFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFC>(arg0, 9, b"CFC", b"CHELSEA ", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65839e83-c8af-44d1-8de4-5ab5f259f177.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

