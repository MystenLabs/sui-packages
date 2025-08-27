module 0xec8dc8cff6e1ee4df94ba90d97e51410f7f12922337c750a13ccd932d9865d24::un {
    struct UN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UN>(arg0, 9, b"UN", b"UNNAMED", b"UNAMED TOKEN JUST FOR TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UN>>(v2, @0x4214f3746036a6dfdbabc23b04deab00ecc63014e9f1ae660614441386e5732e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UN>>(v1);
    }

    // decompiled from Move bytecode v6
}

