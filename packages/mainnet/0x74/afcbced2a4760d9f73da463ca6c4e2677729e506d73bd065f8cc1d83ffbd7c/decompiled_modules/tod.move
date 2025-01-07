module 0x74afcbced2a4760d9f73da463ca6c4e2677729e506d73bd065f8cc1d83ffbd7c::tod {
    struct TOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOD>(arg0, 6, b"TOD", b"TODD SUI", x"746865726527732061206e657720746f646420696e20746f776e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rl_Za_Ek_Kt_400x400_cd9539c0a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

