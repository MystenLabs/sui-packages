module 0xf4bda9f1182943862a5bcbab181cc59b6801ebe4e6978787a5ee9a628baacbf4::lober14 {
    struct LOBER14 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBER14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBER14>(arg0, 9, b"LOBER14", b"LOBSTER", b"Creepy weary freightening meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45983db3-2385-40ab-be57-f8551e23ce4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBER14>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOBER14>>(v1);
    }

    // decompiled from Move bytecode v6
}

