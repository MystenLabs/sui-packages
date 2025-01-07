module 0x8ff372988c9ff527b084960ecff20929aa09538ea2bb67c3ec69e3c3472afa53::club27 {
    struct CLUB27 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUB27, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUB27>(arg0, 6, b"CLUB27", b"Club27", b"We pay our tribute to the legendary 27 club and all the legends that left us to soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031342_67d89c9794.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUB27>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUB27>>(v1);
    }

    // decompiled from Move bytecode v6
}

