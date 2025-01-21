module 0x10828486bd0f6fb8bb756469903a41e914704ec80b35a3bcec5c810ee5c47ad4::t47edmvhpbsi {
    struct T47EDMVHPBSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: T47EDMVHPBSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T47EDMVHPBSI>(arg0, 6, b"T47EDMVHPBSI", b"TRUMP47ElonDogeMagaHarrybtcinu", x"5452554d50343720456c6f6e20446f6765204d6167612056657273652048617272790a506f747465722042746320536f6c616e6120496e75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_031654_292_085491511b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T47EDMVHPBSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T47EDMVHPBSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

