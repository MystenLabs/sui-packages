module 0x8fad1b15df441d6c7aa9ed37d6853299607c7b0634a85aad247d9e8a9b55912e::yaoki {
    struct YAOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAOKI>(arg0, 9, b"YAOKI", b"Yaoki", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/622/909/large/agustin-marceillac-yaoki-illustration-v16.jpg?1728053692")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YAOKI>(&mut v2, 30000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAOKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

