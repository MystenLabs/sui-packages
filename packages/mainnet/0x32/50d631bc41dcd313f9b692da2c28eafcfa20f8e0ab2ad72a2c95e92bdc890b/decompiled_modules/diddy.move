module 0x3250d631bc41dcd313f9b692da2c28eafcfa20f8e0ab2ad72a2c95e92bdc890b::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"Diddy", b"I'm your daddy, bring me Boden and Tremp. I will let them taste my Doddy oil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011141_f0b715a316.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

