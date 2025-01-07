module 0x5656af0d23b0e547b9b3a58b314f095ed1d2e4e8409053fbd70c9678c2668ab5::batman {
    struct BATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATMAN>(arg0, 9, b"Batman", b"Batman", b"The batman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BATMAN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

