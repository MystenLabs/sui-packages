module 0x6f77d4cd375d14847e1c23acd4890aa075daf604c6a83fb2d0c0e5a41d2b047f::btrump {
    struct BTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTRUMP>(arg0, 6, b"BTRUMP", b"BLACKTRUMP", x"464f52204120574f524c4420574954484f55542057484954452121204b494c4c205448454d2121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LL_6_V_Bc_Et_400x400_ac7ecd80a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

