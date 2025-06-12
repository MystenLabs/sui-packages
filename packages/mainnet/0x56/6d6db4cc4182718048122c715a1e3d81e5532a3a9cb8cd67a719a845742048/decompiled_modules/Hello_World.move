module 0x566d6db4cc4182718048122c715a1e3d81e5532a3a9cb8cd67a719a845742048::Hello_World {
    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_WORLD>(arg0, 9, b"HW", b"Hello World", b"Hello everyone in the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/d3e3e64f-8cb9-4713-991d-1bf25a441af9.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_WORLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO_WORLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

