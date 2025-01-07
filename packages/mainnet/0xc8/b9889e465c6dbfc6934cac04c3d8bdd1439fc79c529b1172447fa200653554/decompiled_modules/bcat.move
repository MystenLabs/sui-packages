module 0xc8b9889e465c6dbfc6934cac04c3d8bdd1439fc79c529b1172447fa200653554::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"Bunny Cat", b"Some are trying to be the coolest cat in SUI, but I don't know why they waste energy, since the coolest cat trophy is already mine!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731024375141.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

