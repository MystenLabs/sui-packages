module 0xedcd484e044be3ce7d77c2791a1a3ce5d77a9c8d589977344f113a26ea9ba8fc::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"SHIBA", b"SHIBASUI", x"5348494241204f4e204e4554574f524b0a53756973686962206973206e6f74206a7573742061626f757420696e766573746d656e746974277320616e206570696320616476656e7475726520696e207468652073757065722d6661737420235375692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Miz1hoyx_400x400_4a86bf18f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

