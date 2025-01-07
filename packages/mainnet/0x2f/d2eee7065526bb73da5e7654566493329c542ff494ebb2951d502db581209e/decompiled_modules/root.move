module 0x2fd2eee7065526bb73da5e7654566493329c542ff494ebb2951d502db581209e::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 6, b"ROOT", b"Rootlets", x"4375746520637265617475726573206861766520636f6d652066726f6d2074686520537569766572736520746f20636f6c6f6e697a6520456172746821204765742072656164792c206c6574e28099732072f09f90bd7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730974235313.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

