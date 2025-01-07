module 0x1ac442c11ca0a18d288caf3ebae179f3baead87963b8b596cc2124f252433e64::sphooky {
    struct SPHOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHOOKY>(arg0, 6, b"SPHOOKY", b"Sphooky coin", b"\"Sphooky\" is a fun, Halloween-inspired token that adds a dash of ghostly charm to the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044355_189ecec891.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHOOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPHOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

