module 0x32327504e4151cbe50c3366650682d5e06c7bd7b0c22943ddd41e0f315d908fe::skey {
    struct SKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEY>(arg0, 9, b"SKEY", b"Skeydeg", b"Token of sui key degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKEY>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

