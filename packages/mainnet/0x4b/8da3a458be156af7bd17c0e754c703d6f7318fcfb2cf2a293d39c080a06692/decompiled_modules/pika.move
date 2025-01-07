module 0x4b8da3a458be156af7bd17c0e754c703d6f7318fcfb2cf2a293d39c080a06692::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 2, b"PIKA", b"Pikasui", b"PIKA SUI is the starter of the Sui chain, designed to be your companion as you embark on the Sui chain journey. It's a memecoin that seeks to build enjoyable and amusing elements within the Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/22I33LL.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIKA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

