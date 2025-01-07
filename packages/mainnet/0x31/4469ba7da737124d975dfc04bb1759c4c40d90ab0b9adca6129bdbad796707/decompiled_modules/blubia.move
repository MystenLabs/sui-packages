module 0x314469ba7da737124d975dfc04bb1759c4c40d90ab0b9adca6129bdbad796707::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"Blubia", b"Blubia ON SUI", x"24424c554249412069732024424c55422773205769666520616e642074686520726569676e696e6720515545454e206f662074686520535549204f4345414e2121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_G9_IX_j_H_400x400_af7a6ec1a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

