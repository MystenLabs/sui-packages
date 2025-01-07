module 0x4e302b3d028ffd0862d63943e10256d88a466419a8f018d745d1546fb6e878ac::werobot {
    struct WEROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEROBOT>(arg0, 6, b"WEROBOT", b"WE.ROBOT", b"Tesla product unveil in less than an hour", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_JOF_7o_B_400x400_ca6e84d9a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

