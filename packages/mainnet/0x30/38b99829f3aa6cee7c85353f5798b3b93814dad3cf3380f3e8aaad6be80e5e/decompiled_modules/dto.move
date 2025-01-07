module 0x3038b99829f3aa6cee7c85353f5798b3b93814dad3cf3380f3e8aaad6be80e5e::dto {
    struct DTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTO>(arg0, 6, b"DTO", b"DEVILS TAKEOVER", x"54686520646576696c73206e65766572206c6f73652c20626563616d65207468652072616c6c79696e67206372792c20616e642061732074686520776f726c647320656c6974652066656c6c2c206f6e652074727574682072656d61696e65643a2074686520646576696c73206469646e74206a7573742074616b65206f766572207468657920616c776179732072756c65642e0a0a54484520444556494c204e45564552204c4f4f534520414e442054484953204d454d45434f494e204953204845524520544f2054414b45204f56455220414e4420544f5020544845204348415254", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7452_b4b0128892.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

