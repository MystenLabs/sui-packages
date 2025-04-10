module 0x947e6e4c883260698c884678e8e81a94b40b8c9c4dabd87975c75ab77170ba09::anisui {
    struct ANISUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANISUI>, arg1: 0x2::coin::Coin<ANISUI>) {
        0x2::coin::burn<ANISUI>(arg0, arg1);
    }

    fun init(arg0: ANISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANISUI>(arg0, 9, b"anisui", b"anis", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/libnme9.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANISUI>>(v1);
        0x2::coin::mint_and_transfer<ANISUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANISUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANISUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANISUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

