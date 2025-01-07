module 0xe227ab5bc411029f8b7bce55f2e0427986ee2d88109f85a2dcb4b7a2d8e01370::mgg {
    struct MGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGG>(arg0, 6, b"MGG", b"Memez GG", b"something is cooking ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n8_KMWY_6_400x400_081663c0a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

