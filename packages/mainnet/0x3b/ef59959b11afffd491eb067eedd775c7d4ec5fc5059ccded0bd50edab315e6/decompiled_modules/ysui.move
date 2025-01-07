module 0x3bef59959b11afffd491eb067eedd775c7d4ec5fc5059ccded0bd50edab315e6::ysui {
    struct YSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSUI>(arg0, 6, b"YSUI", b"YELLOW GROUPER ON SUI", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241213_162824_147_efa8add99b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

