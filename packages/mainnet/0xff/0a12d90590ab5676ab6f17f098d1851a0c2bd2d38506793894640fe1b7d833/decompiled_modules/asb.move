module 0xff0a12d90590ab5676ab6f17f098d1851a0c2bd2d38506793894640fe1b7d833::asb {
    struct ASB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASB>(arg0, 6, b"ASB", b"Arena Sui Battles", b"Arena Sui Battles Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prikitiu_dbf49cc58d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASB>>(v1);
    }

    // decompiled from Move bytecode v6
}

