module 0x9bb8c8016e0f6d61bbb4a3618992155bcc6359e69171a127dcd9e088c76da34e::glass {
    struct GLASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLASS>(arg0, 6, b"GLASS", b"Glass of Sui", b"Just a glass of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/finalll_8309c09916.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

