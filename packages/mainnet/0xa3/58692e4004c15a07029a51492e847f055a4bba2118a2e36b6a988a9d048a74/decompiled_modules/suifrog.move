module 0xa358692e4004c15a07029a51492e847f055a4bba2118a2e36b6a988a9d048a74::suifrog {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUIFROG", b"SUI FROG", b"Revolutionize your swapping experience with Sui Frog an Easy Defi on #SUl - the cutting-edge DeFi platform that simplifies the process", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1847988103476396032/1SrhV42Y_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIFROG>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUIFROG>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

