module 0x9ef9a6fc7ee6196c81891c3301679a7ce60d7a550cc852cdcfd12a3a6bb95662::gypsui {
    struct GYPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYPSUI>(arg0, 6, b"GYPSUI", b"Gypsui", x"546865204d6f73742047616e6773746572204d656d6520436f696e206f6e2074686520426c6f636b200a0a4e6f7420796f757220626173696320687573746c652020475950535549207368696e6573206c696b6520676f6c642c20666c65786573206c696b652061204c616d626f2c20616e64206869747320686172646572207468616e206120646973636f2062616c6c2061742074686520636f756e747920666169722e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_23_22_21_17_0509f3c0ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

