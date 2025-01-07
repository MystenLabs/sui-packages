module 0xbbf53fc597cd73c361e33c43967cb6257ec3d7624573d2320cabc18e538919dc::hippe {
    struct HIPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPE>(arg0, 6, b"HIPPE", b"Hippe", b"Hi Im Hippe , A degenerate gambler that doesnt get along with just anyone but I have a lot of friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hippe_Logo_sui_4c7b38a945.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

