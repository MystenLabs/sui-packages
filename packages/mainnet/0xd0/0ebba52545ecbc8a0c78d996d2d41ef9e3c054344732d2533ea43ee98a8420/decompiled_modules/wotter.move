module 0xd00ebba52545ecbc8a0c78d996d2d41ef9e3c054344732d2533ea43ee98a8420::wotter {
    struct WOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOTTER>(arg0, 9, b"WOTTER", b"Underwoter", b"Hello, im underwotter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72456ca1-1f7a-4cc2-9356-48558789cb9b-1000212698.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

