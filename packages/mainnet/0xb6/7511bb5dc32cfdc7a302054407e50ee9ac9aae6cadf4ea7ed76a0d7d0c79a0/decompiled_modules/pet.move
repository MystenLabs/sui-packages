module 0xb67511bb5dc32cfdc7a302054407e50ee9ac9aae6cadf4ea7ed76a0d7d0c79a0::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 6, b"PET", b"MetaPet", x"22446973636f7665722074686520667574757265206f6620706574206f776e6572736869702077697468204d65746150657421204f776e2c2074726164652c20616e64206361726520666f7220756e69717565207669727475616c207065747320696e20746865206d65746176657273652e20436f6c6c6563742072617265206272656564732c206561726e207265776172647320696e206f757220706c61792d746f2d6561726e2065636f73797374656d2c20616e64206275696c64206c6966656c6f6e6720636f6e6e656374696f6e73207769746820796f7572206469676974616c20636f6d70616e696f6e732e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732071112641.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

