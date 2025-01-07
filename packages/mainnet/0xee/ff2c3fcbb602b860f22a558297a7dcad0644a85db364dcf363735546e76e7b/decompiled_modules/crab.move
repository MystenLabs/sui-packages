module 0xeeff2c3fcbb602b860f22a558297a7dcad0644a85db364dcf363735546e76e7b::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CRAB>, arg1: 0x2::coin::Coin<CRAB>) {
        0x2::coin::burn<CRAB>(arg0, arg1);
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"https://i.imgur.com/Y8OIuGF.png");
        let (v1, v2) = 0x2::coin::create_currency<CRAB>(arg0, 9, b"CRAB", b"King Crab", x"547769747465723a2068747470733a2f2f782e636f6d2f6b696e67637261627375693f733d323126743d513476417a575a7653303848346e79345032425350670a54656c653a2068747470733a2f2f742e6d652f486f6c79737569637261620a68747470733a2f2f692e696d6775722e636f6d2f59384f497547462e706e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&v0))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRAB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CRAB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CRAB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

