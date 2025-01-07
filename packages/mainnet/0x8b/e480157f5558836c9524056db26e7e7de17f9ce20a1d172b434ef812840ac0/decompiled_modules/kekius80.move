module 0x8be480157f5558836c9524056db26e7e7de17f9ce20a1d172b434ef812840ac0::kekius80 {
    struct KEKIUS80 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS80, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS80>(arg0, 9, b"KEKIUS80", b"Kekius Maximus 80", x"4265686f6c642c204b656b697573204d6178696d75732038302028244b454b4955533830292c20746865206d656d6520636f696e207468617420456c6f6e204d75736b2068696d73656c6620686173206b6e696768746564207769746820686973206c6567656e646172792070726f66696c652120f09f90b8e29a94efb88f205768656e207468652072696368657374206d656d65206c6f7264206f6e2074686520706c616e6574206368616e67657320686973206e616d6520746f204b656b697573204d6178696d75732c20796f75206b6e6f77206974e28099732074696d6520746f206772616220796f7572206261677320616e64206a6f696e20746865204b656b20637275736164652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRKB6az8f7L5p3WwpJLTLZZcUZHU24WB8djnC8D4qjEiJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEKIUS80>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS80>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS80>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

