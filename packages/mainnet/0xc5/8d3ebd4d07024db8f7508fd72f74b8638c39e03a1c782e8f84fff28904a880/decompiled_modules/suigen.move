module 0xc58d3ebd4d07024db8f7508fd72f74b8638c39e03a1c782e8f84fff28904a880::suigen {
    struct SUIGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGEN>(arg0, 6, b"SuiGen", b"Sui Degen", x"49206e6565642053756920646567656e20636f696e732e0a4920616d2061207472756520646567656e2e0a4920616d2061202453756947656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Gen_logo_2dc105247c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

