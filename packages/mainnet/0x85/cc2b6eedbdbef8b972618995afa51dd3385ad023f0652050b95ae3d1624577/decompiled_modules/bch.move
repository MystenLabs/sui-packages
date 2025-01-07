module 0x85cc2b6eedbdbef8b972618995afa51dd3385ad023f0652050b95ae3d1624577::bch {
    struct BCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCH>(arg0, 6, b"BCH", b"Bitcoin Cash", b"Bitcoin Cash on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_e03ddb299f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

