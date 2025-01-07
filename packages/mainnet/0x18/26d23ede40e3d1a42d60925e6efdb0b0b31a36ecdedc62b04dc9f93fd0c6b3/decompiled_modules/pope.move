module 0x1826d23ede40e3d1a42d60925e6efdb0b0b31a36ecdedc62b04dc9f93fd0c6b3::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"POPE", b"HIPOPE", b"Pepe and the hippo: Forget the rocket, we're hippo-ing our way to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_c960df4483.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

