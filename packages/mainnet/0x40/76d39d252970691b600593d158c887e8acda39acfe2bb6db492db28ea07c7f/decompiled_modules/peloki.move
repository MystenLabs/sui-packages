module 0x4076d39d252970691b600593d158c887e8acda39acfe2bb6db492db28ea07c7f::peloki {
    struct PELOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELOKI>(arg0, 6, b"PELOKI", b"PelokiSui", b"Peloki is the son of Pepe and Floki. He wants to do what their parents do!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peloki_e351b96cf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

