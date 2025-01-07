module 0x519b183c311c00ef6039d3fecdf4221e98c7557f5fa7cb2d618ada8ec3ed9192::beh {
    struct BEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEH>(arg0, 6, b"BEH", b"Blue Eye Husky", b"A Blue Eye Husky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bb800e8a32b65606c3a8687df447a027_752635e316.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

