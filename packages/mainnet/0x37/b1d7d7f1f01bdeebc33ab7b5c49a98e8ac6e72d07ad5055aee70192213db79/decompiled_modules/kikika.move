module 0x37b1d7d7f1f01bdeebc33ab7b5c49a98e8ac6e72d07ad5055aee70192213db79::kikika {
    struct KIKIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKIKA>(arg0, 9, b"KIKIKA", b"KAKIKI", b"THAT WHY IT NO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/123f3d2e-bc50-4201-967d-1ccb759804b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIKIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

