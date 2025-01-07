module 0x862d1dd95e569c40bd9fb98f103a3c05dcb23b51dfe729ee4ddcc44cc3f3da73::flawless {
    struct FLAWLESS has drop {
        dummy_field: bool,
    }

    public entry fun drop_treasury_cap(arg0: 0x2::coin::TreasuryCap<FLAWLESS>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAWLESS>>(arg0, @0x0);
    }

    fun init(arg0: FLAWLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FLAWLESS>(arg0, 3, b"FLAWLESS", b"FLAWLESS", b"FLAWLESS is a coin for the FLAWLESS project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/011/947/129/original/gold-internet-icon-free-png.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAWLESS>>(v2);
        0x2::coin::mint_and_transfer<FLAWLESS>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAWLESS>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

