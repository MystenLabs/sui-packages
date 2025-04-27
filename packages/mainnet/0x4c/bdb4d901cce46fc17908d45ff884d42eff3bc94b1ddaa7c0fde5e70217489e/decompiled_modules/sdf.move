module 0x4cbdb4d901cce46fc17908d45ff884d42eff3bc94b1ddaa7c0fde5e70217489e::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 9, b"SD", b"sdf", b"sdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDF>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

