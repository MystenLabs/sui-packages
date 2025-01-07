module 0x18938b97cfafee4a6ccdf5d287a0d5441d5fa5e8388bd9d8a4606a3f6dfecf86::suirooster {
    struct SUIROOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROOSTER>(arg0, 6, b"SUIROOSTER", b"Official Sui Rooster", b"First Rooster on Sui: suirooster.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_35_2a460f3574.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROOSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROOSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

