module 0x58825a01773888007ba5e1436a43d03586ac7cefe3b63f665cc1fa0814980fb9::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 6, b"EDOG", b"Edog sui", x"526561647920746f204c4f4c3f204d656574204045444f475375690a2074686520646f672077686f207468696e6b73206865277320612070726f2067616d657220627574206b6565707320726167652d7175697474696e6720276361757365207061777320646f6e742068617665207468756d6273200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040651_7ffa6599ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

