module 0xad0eed9007fb0b8cdef8b462d492f1bcee6501e191b7313bd88fd681494d5e22::troppy {
    struct TROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROPPY>(arg0, 6, b"TROPPY", b"Troppy Coin", b"$TROPPY originates from Matt Furie's most hallucinogenic amphibian. He's heavily displayed in MINDVISCOSITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048623_6e008db558.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

