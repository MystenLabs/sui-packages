module 0x252ddf03c04b0b78cdf3971e1cf440e8bbfd77518642d7036a92b8a74ac94342::PHASETEST1 {
    struct PHASETEST1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PHASETEST1>, arg1: 0x2::coin::Coin<PHASETEST1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PHASETEST1>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PHASETEST1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PHASETEST1>>(0x2::coin::mint<PHASETEST1>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<PHASETEST1>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PHASETEST1>>(arg0);
    }

    fun init(arg0: PHASETEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHASETEST1>(arg0, 9, b"PhaseTest1", b"PhaseTest 1", b"Testing PhaseTest 1 Lorem bla bla bla, bla bla bla, bla bla. Testing PhaseTest 1 Lorem bla bla bla, bla bla bla, bla bla. Testing PhaseTest 1 Lorem bla bla bla, bla bla bla, bla bla. Testing PhaseTest 1 Lorem bla bla bla, bla bla bla, bla bla.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_6886628bae68a0.25030183.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHASETEST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHASETEST1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

