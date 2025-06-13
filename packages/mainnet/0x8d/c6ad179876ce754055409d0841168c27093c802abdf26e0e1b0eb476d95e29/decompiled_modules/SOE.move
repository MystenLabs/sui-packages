module 0x8dc6ad179876ce754055409d0841168c27093c802abdf26e0e1b0eb476d95e29::SOE {
    struct SOE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOE>, arg1: 0x2::coin::Coin<SOE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SOE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SOE>>(0x2::coin::mint<SOE>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SOE>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOE>>(arg0);
    }

    fun init(arg0: SOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOE>(arg0, 9, b"SOE", b"Some Enterprise", b"Test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61xa1mU0OYL._AC_UF1000,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

