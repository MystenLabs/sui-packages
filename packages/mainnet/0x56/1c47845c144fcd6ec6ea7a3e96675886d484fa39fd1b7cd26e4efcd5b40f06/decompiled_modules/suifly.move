module 0x561c47845c144fcd6ec6ea7a3e96675886d484fa39fd1b7cd26e4efcd5b40f06::suifly {
    struct SUIFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLY>(arg0, 6, b"Suifly", b"Sui fly", b"Fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906017_43737883cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

