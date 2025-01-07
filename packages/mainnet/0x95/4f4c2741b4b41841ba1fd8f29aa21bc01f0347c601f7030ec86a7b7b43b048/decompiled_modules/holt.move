module 0x954f4c2741b4b41841ba1fd8f29aa21bc01f0347c601f7030ec86a7b7b43b048::holt {
    struct HOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLT>(arg0, 9, b"HOLT", b"HOT LOVE", b"HOT LOVE IS POWER MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55d21f30-34d4-42b7-a2bc-08d36ed84435.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

