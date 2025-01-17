module 0x2925d5068b16b4ea1a572ae0882348846026e294e4d6f97d984dfd57e25dbdb1::aixsui {
    struct AIXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXSUI>(arg0, 6, b"AIXSUI", b"aixsui by SuiAI", b"AIXSUI tracks Sui ecosystem discussions and leverages its proprietary AI engine to identify high-growth opportunities within the network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aixsui_808f0202c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

