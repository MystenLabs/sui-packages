module 0xc88380aca731c14cfa01340f84344dbc163569bffb0c4d7f0be4b06d429f6afb::ccats {
    struct CCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCATS>(arg0, 6, b"CCats", b"Cool Cats", b"$CCats Cool Cats coming Sui yet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4011_06bb9874a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

