module 0xb2d59c7859d360bfd242471bdaf9b9cc7031f3a89d9893719560d7e66dd8c4b0::movebitch {
    struct MOVEBITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEBITCH>(arg0, 6, b"Movebitch", b"MOVINGTON", b"MOVINGTO1n", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunny_6e5abdf44d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEBITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEBITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

