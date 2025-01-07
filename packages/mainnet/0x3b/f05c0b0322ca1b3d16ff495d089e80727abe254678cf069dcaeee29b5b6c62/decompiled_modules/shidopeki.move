module 0x3bf05c0b0322ca1b3d16ff495d089e80727abe254678cf069dcaeee29b5b6c62::shidopeki {
    struct SHIDOPEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIDOPEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIDOPEKI>(arg0, 6, b"SHIDOPEKI", b"SHIDOPEKI SUI", b"$SHIDOPEKI on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5037032386453_d5ad5b6737b2f78affda358b75d38586_ff47df0bf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIDOPEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIDOPEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

