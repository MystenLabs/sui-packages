module 0x6e93ec4c6999fbf3cb681cffe8576171b8491f49d93ba80343d6e2fc1043abe6::mrwitchcat {
    struct MRWITCHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRWITCHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRWITCHCAT>(arg0, 6, b"MRWITCHCAT", b"MrWitchcat", b"Halloween cat is mr Witchcat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030905_67f030d14b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRWITCHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRWITCHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

