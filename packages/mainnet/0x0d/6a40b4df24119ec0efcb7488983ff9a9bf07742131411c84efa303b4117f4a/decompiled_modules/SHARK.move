module 0xd6a40b4df24119ec0efcb7488983ff9a9bf07742131411c84efa303b4117f4a::SHARK {
    struct SHARK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHARK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHARK>>(0x2::coin::mint<SHARK>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SHARK>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHARK>>(arg0);
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 9, b"SHARK", b"Sui Shark", b"SHARK is a fierce memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Shark_Team_Logo_c809df4645.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

