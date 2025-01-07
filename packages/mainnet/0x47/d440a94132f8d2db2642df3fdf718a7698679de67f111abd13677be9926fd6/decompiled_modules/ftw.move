module 0x47d440a94132f8d2db2642df3fdf718a7698679de67f111abd13677be9926fd6::ftw {
    struct FTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTW>(arg0, 6, b"FTW", b"Fish Tape Wall", b"fish_bandit84 was the legendary kid who taped fish to ATMs, police cars, restaurant bathrooms and everywhere else he can. Time to build the cult on Sui and tape fish everywhere. FB84", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fsh_ea3cc83b01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

