module 0x175083666c2220fa347c21bd48d49b9fe1091d9a4ae7e4204a6b4f1b8a213d68::jimbo {
    struct JIMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIMBO>(arg0, 6, b"JIMBO", b"Jimmy Neutron", b"Its Jimbo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jimmy_Neutron_1a3d5b8513.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

