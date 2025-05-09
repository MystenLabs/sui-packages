module 0x2e9117ed3a6bd56caca2ea33d5dc02a4eb0445ed4d166761ad37b84f4469b914::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 6, b"AVATAR", b"AVATAR on SUI", x"415641544152535549204f4e20484953205741590a546865206c6173742061697262656e64657220696e207468652063727970746f20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigll7vk64fjrmklc5v6jtz4ejtahqw6wkgpqsmu5scdcb4p5anvda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AVATAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

