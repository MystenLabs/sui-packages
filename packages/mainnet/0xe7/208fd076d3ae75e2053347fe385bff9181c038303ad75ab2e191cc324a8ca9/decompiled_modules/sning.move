module 0xe7208fd076d3ae75e2053347fe385bff9181c038303ad75ab2e191cc324a8ca9::sning {
    struct SNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNING>(arg0, 6, b"SNING", b"SUINNING", b"You may even get tired of Suinning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINNING_025e9f49f4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

