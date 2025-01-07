module 0xaa8e9475738dc203ec601f514ee7798a4e23471f7a08b12a91c5fbe1c326e260::bongo {
    struct BONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGO>(arg0, 6, b"BONGO", b"Sui Bongo", b"Bongo - Cat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_174914_547024e665.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

