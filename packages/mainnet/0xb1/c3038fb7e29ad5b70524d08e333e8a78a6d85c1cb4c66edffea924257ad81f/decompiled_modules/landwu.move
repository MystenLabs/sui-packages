module 0xb1c3038fb7e29ad5b70524d08e333e8a78a6d85c1cb4c66edffea924257ad81f::landwu {
    struct LANDWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANDWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANDWU>(arg0, 6, b"LANDWU", b"LandWU sui", b"$LANDWU is alter ego of your favorite boy's club character landWolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000256_20c0b0a560.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANDWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANDWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

