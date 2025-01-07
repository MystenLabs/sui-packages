module 0x1a9ccac30c33697f00e34bee49c169caf171cd122dd8b605e93e1ac51e0fde51::gmsui {
    struct GMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMSUI>(arg0, 6, b"GMSUI", b"gm sui frens", b"first gm sui frens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_4_3289b876e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

