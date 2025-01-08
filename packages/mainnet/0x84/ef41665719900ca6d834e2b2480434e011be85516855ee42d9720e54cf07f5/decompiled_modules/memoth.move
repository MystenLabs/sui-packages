module 0x84ef41665719900ca6d834e2b2480434e011be85516855ee42d9720e54cf07f5::memoth {
    struct MEMOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMOTH>(arg0, 6, b"MEMOTH", b"Sui Memoth", b"$MEMOTH: The legendary leader of the crypto community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022423_f32c072daa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

