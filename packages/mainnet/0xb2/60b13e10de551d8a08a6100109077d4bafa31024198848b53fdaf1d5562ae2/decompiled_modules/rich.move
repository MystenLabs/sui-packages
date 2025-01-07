module 0xb260b13e10de551d8a08a6100109077d4bafa31024198848b53fdaf1d5562ae2::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 9, b"RICH", b"Oxtrich", b"Oxtrich meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreibniqfdwbt7isccjdmtzgtcwycsdggdpptnqmb457mu6fxorz25oq.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RICH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

