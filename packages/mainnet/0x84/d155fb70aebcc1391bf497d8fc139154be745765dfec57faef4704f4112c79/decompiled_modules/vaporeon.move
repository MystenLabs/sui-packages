module 0x84d155fb70aebcc1391bf497d8fc139154be745765dfec57faef4704f4112c79::vaporeon {
    struct VAPOREON has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOREON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOREON>(arg0, 8, b"VAPOREON", b"Vaporeon", b"Our favorite water-type pokemon swimming on Sui. Twitter: @VaporProtocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/bmG3krz/Vaporeon.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VAPOREON>(&mut v2, 2100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOREON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAPOREON>>(v1);
    }

    // decompiled from Move bytecode v6
}

