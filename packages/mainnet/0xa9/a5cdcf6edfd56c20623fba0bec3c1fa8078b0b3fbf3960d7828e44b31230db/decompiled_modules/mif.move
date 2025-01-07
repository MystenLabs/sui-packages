module 0xa9a5cdcf6edfd56c20623fba0bec3c1fa8078b0b3fbf3960d7828e44b31230db::mif {
    struct MIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIF>(arg0, 6, b"MIF", b"Moose in the fog", b"Beautiful innit? Now send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0766_5a198a70cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

