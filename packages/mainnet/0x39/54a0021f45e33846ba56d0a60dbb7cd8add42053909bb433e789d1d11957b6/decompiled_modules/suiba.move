module 0x3954a0021f45e33846ba56d0a60dbb7cd8add42053909bb433e789d1d11957b6::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 9, b"SUIBA", b"SUIBA INU", b"SUIBA INUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogtime.com/wp-content/uploads/sites/12/2011/01/GettyImages-653001154-e1691965000531.jpg?w=1024")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

