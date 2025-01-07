module 0x5cd7eb538c507a143535b5830b2ba824bd4676191707d0cd9cb5f12038911c8a::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 5, b"PIZZA", b"Pizza with Pepperoni", b"A delicious pizza with pepperoni", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://previews.123rf.com/images/rez_art/rez_art2007/rez_art200700027/151521440-grande-pizza-au-pepperoni-et-au-fromage-de-style-am%C3%A9ricain-dans-une-bo%C3%AEte-de-livraison-en-carton.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<PIZZA>(&mut v2, 5000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

