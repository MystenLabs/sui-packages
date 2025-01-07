module 0x143f88f9362b13153f1e9ab5494d5443f8d6df3f153f5a61c0626e03e927b1a1::ippy {
    struct IPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPPY>(arg0, 9, b"IPPY", b"Ippy stroy", b"IPPY on stroy protocall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4f4cf5d41d9aef01f7ce7458cedda33eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

