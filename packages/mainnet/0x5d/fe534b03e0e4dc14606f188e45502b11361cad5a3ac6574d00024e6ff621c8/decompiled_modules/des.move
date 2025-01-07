module 0x5dfe534b03e0e4dc14606f188e45502b11361cad5a3ac6574d00024e6ff621c8::des {
    struct DES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES>(arg0, 9, b"DES", b"Desteany", b"To the moon. HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddfeaa8b-77d1-470d-82dd-c150f14aa373.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DES>>(v1);
    }

    // decompiled from Move bytecode v6
}

