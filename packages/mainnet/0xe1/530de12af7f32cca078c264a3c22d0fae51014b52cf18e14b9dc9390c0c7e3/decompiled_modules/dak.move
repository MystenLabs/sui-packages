module 0xe1530de12af7f32cca078c264a3c22d0fae51014b52cf18e14b9dc9390c0c7e3::dak {
    struct DAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAK>(arg0, 6, b"DAK", b"DAK SUI", b"Empowering Your Future with dak: The Coin that Soars!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x41636c138167952207c88f5a75e433c9e880bc7bd5e4e46047d82be266d36712_dak_dak_fda1f77146.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

