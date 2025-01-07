module 0x11ad35dd44602eb8d0c84fe0510e5701ed4ab9eb70f07b5bdf5c553ff9ee4ea6::suizou {
    struct SUIZOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZOU>(arg0, 6, b"SUIZOU", b"Suizou", b"Oui oui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030447_cc83187029.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

