module 0x26b0a884b8f42f6583b82fa633b212ed7da3ca43c50853962b37ccaf8121ec56::noo {
    struct NOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOO>(arg0, 6, b"NOO", b"Noo Cat", b"Dont fade noooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_195228_91c91ad072.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

