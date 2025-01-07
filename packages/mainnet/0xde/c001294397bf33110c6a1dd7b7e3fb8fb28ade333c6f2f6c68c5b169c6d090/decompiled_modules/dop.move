module 0xdec001294397bf33110c6a1dd7b7e3fb8fb28ade333c6f2f6c68c5b169c6d090::dop {
    struct DOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOP>(arg0, 6, b"DOP", b"DOP on SUI", b"Launching on @Turbos_finance. DOP fuck HOP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975899334.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

