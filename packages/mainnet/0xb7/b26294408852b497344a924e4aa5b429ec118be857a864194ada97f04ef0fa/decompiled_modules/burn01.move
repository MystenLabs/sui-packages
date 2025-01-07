module 0xb7b26294408852b497344a924e4aa5b429ec118be857a864194ada97f04ef0fa::burn01 {
    struct BURN01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN01>(arg0, 6, b"Burn01", b"burn01", b"burn01burn01burn01", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730905213065.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURN01>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN01>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

