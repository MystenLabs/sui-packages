module 0xf59501365ef2c00b324cb402dcb2bbb4ac6a4d2610221927c03eeda9325ce6::b_giz {
    struct B_GIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GIZ>(arg0, 9, b"bGIZ", b"bToken GIZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

