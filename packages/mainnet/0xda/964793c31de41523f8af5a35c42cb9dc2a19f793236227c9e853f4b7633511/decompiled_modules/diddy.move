module 0xda964793c31de41523f8af5a35c42cb9dc2a19f793236227c9e853f4b7633511::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"Diddy Baby Oil", b"I'm your daddy, bring me Boden and Tremp. I will let them taste my Doddy oil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011141_8796f62aac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

