module 0xc74ace59e78c46380c330a3da47034dced9d3b68908cf8756d38b620854c815e::squrac {
    struct SQURAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQURAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQURAC>(arg0, 6, b"SQURAC", b"Squrac On Sui", b"SQURAC is a combination of squirrel and raccoon, his father is peanut the convicted squirrel and his mother is convicted raccoon. They both met in jail.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048042_f7ff839ae9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQURAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQURAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

