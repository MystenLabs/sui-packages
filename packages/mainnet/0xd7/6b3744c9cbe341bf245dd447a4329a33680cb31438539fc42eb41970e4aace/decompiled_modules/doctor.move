module 0xd76b3744c9cbe341bf245dd447a4329a33680cb31438539fc42eb41970e4aace::doctor {
    struct DOCTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOCTOR>(arg0, 6, b"DOCTOR", b"Dr Solwitz", b"EAT APPLE A DAY TO MAKE DOCTORS AWAY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NURSE_b984de513b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOCTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOCTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

