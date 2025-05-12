module 0xf48ebed861ea163cc7e59eb7e07de0a591ab327228fb056c59d15ccf08eebe98::shes {
    struct SHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHES>(arg0, 9, b"SHES", b"Shoes", b"buy shoes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9b00d371bce01e76c6e13d7d09f09195blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

