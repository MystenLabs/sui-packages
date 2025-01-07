module 0xc4c098d2e2e61ffc85d8911a5e259e32cb653e565742c204fa3e39fcd98c1a2b::suipp {
    struct SUIPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPP>(arg0, 6, b"SUIPP", b"Pax and Polly", b"Pax and Polly are an adorable penguin couple in the Pudgy Penguins community, often featured in the projects animated videos. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_B_Ksn_TOJ_400x400_c79db5e87c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

