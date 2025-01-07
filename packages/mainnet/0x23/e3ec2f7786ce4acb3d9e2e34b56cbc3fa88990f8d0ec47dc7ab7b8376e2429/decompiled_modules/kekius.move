module 0x23e3ec2f7786ce4acb3d9e2e34b56cbc3fa88990f8d0ec47dc7ab7b8376e2429::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 9, b"KEKIUS", b"KEKIUS", b"KEKIUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1874012164832583680/86bfAb0N_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEKIUS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

