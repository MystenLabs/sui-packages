module 0x19eb3f233b61f3e7911a5bd5fc699b6fd3cd2dae50a670ede5cc3542567be21a::messui {
    struct MESSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSUI>(arg0, 6, b"MESSUI", b"MESSI COIN ON SUI", b"THE GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/64142948_804_2f578db036.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

