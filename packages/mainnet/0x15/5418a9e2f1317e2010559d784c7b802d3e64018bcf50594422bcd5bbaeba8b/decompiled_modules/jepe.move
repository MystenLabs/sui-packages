module 0x155418a9e2f1317e2010559d784c7b802d3e64018bcf50594422bcd5bbaeba8b::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"JEPE", b"Jelly Pepe", b"the most memeable jellyfish on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952460147.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

