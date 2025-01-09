module 0x8d9c1e3cede29b7172aba9c4af9334a7eb0a4f30be5c0141ea56924fe35bb97c::aadas {
    struct AADAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AADAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AADAS>(arg0, 6, b"Aadas", b"dev", b"asda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bf545786_900c_4294_8058_316e0b7ee0aa_22143fd058.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AADAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AADAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

