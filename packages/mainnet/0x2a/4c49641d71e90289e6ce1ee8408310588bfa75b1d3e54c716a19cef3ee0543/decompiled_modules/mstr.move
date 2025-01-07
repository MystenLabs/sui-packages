module 0x2a4c49641d71e90289e6ce1ee8408310588bfa75b1d3e54c716a19cef3ee0543::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"Mstr", b"$MSTR: The Crypto Enthusiast Stock   *Not affiliated with the MicroStrategy Incorporated | https://t.me/MSTR2100Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6704be250b29abf351d01251_1728364069_edb5b56380.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

