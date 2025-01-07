module 0x6bef06d676f73bf819d147343efb0927b746fd68373833f6b5ed243d95e83135::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 6, b"RICKY", b"Ricky the penguin", b"Hey, it's Ricky!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pinguino_para_ia_24be092174.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

