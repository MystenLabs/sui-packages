module 0x6cf2a1f17a45946bfc3aa7e60838ceaa2a890f4b11e71ef455b1d1f2ae4fead2::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 6, b"SMOON", b"Suilor SNPR", b"SNPR fk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_Art_ed9486a450.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

