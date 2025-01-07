module 0x8797d635bcfb77a95cf74043c0202fc0a773244890a1ba19738f15923f592688::nawn {
    struct NAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAWN>(arg0, 6, b"NAWN", b"Seal Nawn", b"get it the f*ck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_160111_a6b6cefc41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

