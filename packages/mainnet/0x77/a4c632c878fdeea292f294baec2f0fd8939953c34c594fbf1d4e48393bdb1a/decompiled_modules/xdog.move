module 0x77a4c632c878fdeea292f294baec2f0fd8939953c34c594fbf1d4e48393bdb1a::xdog {
    struct XDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDOG>(arg0, 6, b"XDOG", b"XDOG on SUI", b"XDog on SUI. Always Wrong, Never Correct", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_DXR_1ko_N_400x400_acbfcac0c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

