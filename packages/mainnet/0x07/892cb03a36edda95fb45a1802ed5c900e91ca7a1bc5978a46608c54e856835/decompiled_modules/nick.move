module 0x7892cb03a36edda95fb45a1802ed5c900e91ca7a1bc5978a46608c54e856835::nick {
    struct NICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICK>(arg0, 6, b"NICK", b"Nick a lodeon", b"just black cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae4e50dc568ee21189d43f4fbb1911d7_3ee049b87e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

