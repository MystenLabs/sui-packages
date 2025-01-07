module 0x33ebe2e5ffea96afda5341c3c51d763e723fc96db8e5f191dae4e8557585f4d2::holiday {
    struct HOLIDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLIDAY>(arg0, 9, b"HOLIDAY", b"@Holiday@", b"Holiday Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29800efd-e93b-43fd-8bca-097471e95870.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLIDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLIDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

