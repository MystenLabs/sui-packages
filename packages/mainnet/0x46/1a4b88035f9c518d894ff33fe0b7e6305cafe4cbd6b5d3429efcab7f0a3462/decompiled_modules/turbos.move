module 0x461a4b88035f9c518d894ff33fe0b7e6305cafe4cbd6b5d3429efcab7f0a3462::turbos {
    struct TURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS>(arg0, 6, b"Turbos", b"Turbos finance", b"Turbos Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949914956.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

