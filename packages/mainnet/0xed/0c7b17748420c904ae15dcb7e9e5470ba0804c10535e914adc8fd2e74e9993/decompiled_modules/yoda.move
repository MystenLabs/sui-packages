module 0xed0c7b17748420c904ae15dcb7e9e5470ba0804c10535e914adc8fd2e74e9993::yoda {
    struct YODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA>(arg0, 6, b"YODA", b"Sui Yoda", b"The force is strong with this one! Sui Yoda guides you through the vast galaxy of Sui with wisdom and power. You dont need to be a Jedi to master this memecoin just a true believer in the green master of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yoda_1ad426f9f1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

