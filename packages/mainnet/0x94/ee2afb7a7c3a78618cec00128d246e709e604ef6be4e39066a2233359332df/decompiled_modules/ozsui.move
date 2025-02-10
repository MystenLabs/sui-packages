module 0x94ee2afb7a7c3a78618cec00128d246e709e604ef6be4e39066a2233359332df::ozsui {
    struct OZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZSUI>(arg0, 6, b"OZSUI", b"OZON ON SUI", b"Welcome to Ozon first AI Delivery System on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OZON_LOGO_01_c7cda6a20a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

