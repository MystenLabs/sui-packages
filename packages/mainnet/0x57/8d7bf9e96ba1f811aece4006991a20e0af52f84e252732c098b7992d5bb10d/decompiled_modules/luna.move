module 0x578d7bf9e96ba1f811aece4006991a20e0af52f84e252732c098b7992d5bb10d::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"LunaCheck", b"Luna, the degen companion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEOW_b258c191e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

