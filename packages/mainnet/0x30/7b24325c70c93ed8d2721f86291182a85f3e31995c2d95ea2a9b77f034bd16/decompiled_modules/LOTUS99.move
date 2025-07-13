module 0x307b24325c70c93ed8d2721f86291182a85f3e31995c2d95ea2a9b77f034bd16::LOTUS99 {
    struct LOTUS99 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOTUS99>, arg1: 0x2::coin::Coin<LOTUS99>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LOTUS99>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOTUS99>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOTUS99>>(0x2::coin::mint<LOTUS99>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<LOTUS99>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOTUS99>>(arg0);
    }

    fun init(arg0: LOTUS99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTUS99>(arg0, 9, b"LOTUS99", b"LOTUS 99", b"Lotus 99 desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:3000/lotus_logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOTUS99>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTUS99>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

