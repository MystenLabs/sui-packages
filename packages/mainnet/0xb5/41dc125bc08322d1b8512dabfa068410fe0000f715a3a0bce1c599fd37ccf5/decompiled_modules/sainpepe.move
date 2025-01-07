module 0xb541dc125bc08322d1b8512dabfa068410fe0000f715a3a0bce1c599fd37ccf5::sainpepe {
    struct SAINPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAINPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAINPEPE>(arg0, 6, b"SAINPEPE", b"Pepe the saint on sui", x"486f70206f6e2074686520245361696e506570652021200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_GOD_7602156bb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAINPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAINPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

