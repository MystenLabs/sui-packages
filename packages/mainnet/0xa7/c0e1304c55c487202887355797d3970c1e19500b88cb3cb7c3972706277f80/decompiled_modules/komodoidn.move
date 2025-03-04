module 0xa7c0e1304c55c487202887355797d3970c1e19500b88cb3cb7c3972706277f80::komodoidn {
    struct KOMODOIDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMODOIDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMODOIDN>(arg0, 9, b"KOMODOIDN", b"KOMODO", b"KOMODO animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/465379b8-ffb7-4da5-bb7d-1fe5a5e0ec1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMODOIDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOMODOIDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

