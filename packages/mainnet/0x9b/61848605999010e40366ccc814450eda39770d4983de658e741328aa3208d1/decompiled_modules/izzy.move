module 0x9b61848605999010e40366ccc814450eda39770d4983de658e741328aa3208d1::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"IZZY", b"IZZYSUI", b"Izzy is Matt Furie,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigonvarr5hwxbrefnukvv4abiw7i5mrjkdz3tyyszde4shzplgiie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IZZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

