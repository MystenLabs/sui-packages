module 0xc4c8ad3813f96b3ea3c3bfa8895f8fc99b36dbbea9d9d591f6aed87633a204aa::SLIME {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"SUI SLIME", b"We are leader of the sui season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/L6grFX5/400jpg.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIME>>(v1);
        0x2::coin::mint_and_transfer<SLIME>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun renounceOwnership(arg0: 0x2::coin::TreasuryCap<SLIME>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

