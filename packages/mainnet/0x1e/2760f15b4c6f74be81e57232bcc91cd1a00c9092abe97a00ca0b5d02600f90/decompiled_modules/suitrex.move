module 0x1e2760f15b4c6f74be81e57232bcc91cd1a00c9092abe97a00ca0b5d02600f90::suitrex {
    struct SUITREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITREX>(arg0, 6, b"SUITREX", b"SUIDINO", b"eating all the fish from the pond of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9363ebc5e8fad43049a09b57b77022fe_d642824d1d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

