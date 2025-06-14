module 0x9582d23d0026631d6073aa4bf7c3716476bcc4389aeef1fa928809298483e061::FANTA {
    struct FANTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FANTA>, arg1: 0x2::coin::Coin<FANTA>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FANTA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FANTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FANTA>>(0x2::coin::mint<FANTA>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<FANTA>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FANTA>>(arg0);
    }

    fun init(arg0: FANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANTA>(arg0, 9, b"FANTA", b"FANTA SUI", b"Fanta Sui Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.turbologo.com/blog/en/2020/02/19084623/Fanta-logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

