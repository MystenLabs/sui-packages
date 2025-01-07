module 0xbcdee3925de58a64f91f03eed0612a9ab5ad7259d96d709a566f34f21077c04::suimi {
    struct SUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMI>(arg0, 6, b"SUIMI", b"Timi Suimi", b"Timi on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7212_c449061b0a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

