module 0x2fb4cdd669d08da4f61f284e311ca22029fd6d3bbfbd3eaaadccfc2c5e83644a::pt {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 9, b"PT-sSUI-250507", b"PT-sSUI-250507", b"PT-sSUI-250507", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/ptTokenSui.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

