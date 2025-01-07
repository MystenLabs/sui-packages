module 0x6984e7c53976e94c9947596db8b8ed6d88be53da1e443b5d160a4c9f5c22c22f::dx {
    struct DX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DX>(arg0, 6, b"Dx", b"Dxatroce", b"welcome les dx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chaise_44e3567781.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DX>>(v1);
    }

    // decompiled from Move bytecode v6
}

