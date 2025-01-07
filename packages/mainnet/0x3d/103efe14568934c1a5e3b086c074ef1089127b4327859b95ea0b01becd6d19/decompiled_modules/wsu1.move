module 0x3d103efe14568934c1a5e3b086c074ef1089127b4327859b95ea0b01becd6d19::wsu1 {
    struct WSU1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSU1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSU1>(arg0, 6, b"Wsu1", b"wsui", b"it just opposite side of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Do_Use_appropriate_spacing_d6c0499e27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSU1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSU1>>(v1);
    }

    // decompiled from Move bytecode v6
}

