module 0x301bd5ae651d575a015b33c95af98fe6d4ed2ef45e2ecfdafc9e2cc0a9b6f720::gods {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 6, b"GODS", b"GODZZILA SMOKE", b"SMOKING GODZZILA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5ae4b8c034445c9decbdd84793b2455d_b89616f20f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODS>>(v1);
    }

    // decompiled from Move bytecode v6
}

