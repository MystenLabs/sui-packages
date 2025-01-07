module 0xe0554b4a927c29ae777ee8ddd9acb436d32a2e5c83fc05cefe0a4be86ff12b4f::gos {
    struct GOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOS>(arg0, 6, b"GOS", b"Game of Sui", x"0a0a0a0a47616d65206f66205375692024474f532056616c6172206d6f726768756c69732022416c6c206d656d65636f696e73206d75737420646965222057652077616e7420746f20636c696d62207468652069726f6e207468726f6e652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241016_150119_dad3e01203.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

