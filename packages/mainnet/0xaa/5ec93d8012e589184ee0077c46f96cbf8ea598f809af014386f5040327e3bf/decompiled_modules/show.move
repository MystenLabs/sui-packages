module 0xaa5ec93d8012e589184ee0077c46f96cbf8ea598f809af014386f5040327e3bf::show {
    struct SHOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOW>(arg0, 6, b"Show", b"showandtell", b"showandtell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_asset_9b66956bbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

