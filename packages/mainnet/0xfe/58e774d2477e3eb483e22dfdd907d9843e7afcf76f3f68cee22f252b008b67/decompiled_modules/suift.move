module 0xfe58e774d2477e3eb483e22dfdd907d9843e7afcf76f3f68cee22f252b008b67::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"Suif", b"Taylor Suift", b"Suiba Wif Hat $SUIF is here to take on the world with smiles and cuteness! His name is Suif, the first and only Suiba Inu on Sui chain and he comes Wif Hat. Let him take you on a journey you wont forget!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSuif500x500_04f4da93fe.png&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

