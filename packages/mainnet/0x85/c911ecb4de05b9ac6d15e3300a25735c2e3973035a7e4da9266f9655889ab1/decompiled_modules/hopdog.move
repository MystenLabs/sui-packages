module 0x85c911ecb4de05b9ac6d15e3300a25735c2e3973035a7e4da9266f9655889ab1::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOG>(arg0, 6, b"HOPDOG", b"HOPDOGONSUI", b"$HOPDOG, Sui's and Hop's best dog! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018440_5d57a663ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

