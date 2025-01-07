module 0x8fbfd09977d68919310cc42103f7cd4c4e92173c695b6d26836b63c984383c49::bao {
    struct BAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAO>(arg0, 6, b"BAO", b"SUIBAO", x"496e20746865206c7573682062616d626f6f20666f7265737473206f6620746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibao_b46475fe4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

