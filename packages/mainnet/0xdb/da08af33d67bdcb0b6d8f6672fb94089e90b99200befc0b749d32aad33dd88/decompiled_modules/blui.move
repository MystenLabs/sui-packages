module 0xdbda08af33d67bdcb0b6d8f6672fb94089e90b99200befc0b749d32aad33dd88::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"BLUI", b"BLUI ON SUI", x"594f2e2e69276d2024424c5549202e2020426c756520666163652c20636c65616e6572206865617274207468616e20796f75722045582021210a5369636b206f66206d656d6520746861742070726f6d69736520746865206d6f6f6e206275742064656c69766572206120504542424c453f0a73616d65202121207468617427732077687920692073686f7765642075702e20776562736974653f3f2069276d20776f726b696e67206f6e2069742c206a7573742062757920616e6420686f6c6420796f757220626167", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmhrgykrhx6q6p5qv2rde5tbrponyhcgsss2wzggasfbkmxdz3cq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

