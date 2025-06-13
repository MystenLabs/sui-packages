module 0x825c9922772d46ecee73bfcf1b7b2428773e138da251a766db27cbaf4fe45316::SUI6900 {
    struct SUI6900 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI6900>, arg1: 0x2::coin::Coin<SUI6900>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUI6900>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI6900>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI6900>>(0x2::coin::mint<SUI6900>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUI6900>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI6900>>(arg0);
    }

    fun init(arg0: SUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900>(arg0, 9, b"SUI6900", b"SUI 6900", b"CoinDesc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61xa1mU0OYL._AC_UF1000,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI6900>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

