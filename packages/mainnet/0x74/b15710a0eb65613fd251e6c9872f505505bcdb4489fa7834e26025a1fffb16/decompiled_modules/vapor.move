module 0x74b15710a0eb65613fd251e6c9872f505505bcdb4489fa7834e26025a1fffb16::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOR>(arg0, 6, b"VAPOR", b"Vaporware", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/JqQcpVK/favicon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAPOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(0x2::coin::mint<VAPOR>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun perform_action(arg0: &mut 0x2::coin::TreasuryCap<VAPOR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        perform_step_2(perform_step_1(arg0, arg1, arg3), arg2);
    }

    fun perform_step_1(arg0: &mut 0x2::coin::TreasuryCap<VAPOR>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAPOR> {
        0x2::coin::mint<VAPOR>(arg0, arg1, arg2)
    }

    fun perform_step_2(arg0: 0x2::coin::Coin<VAPOR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

