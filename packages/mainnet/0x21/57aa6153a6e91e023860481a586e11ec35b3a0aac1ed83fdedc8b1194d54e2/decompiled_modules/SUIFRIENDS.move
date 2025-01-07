module 0x2157aa6153a6e91e023860481a586e11ec35b3a0aac1ed83fdedc8b1194d54e2::SUIFRIENDS {
    struct SUIFRIENDS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIFRIENDS>, arg1: 0x2::coin::Coin<SUIFRIENDS>) {
        0x2::coin::burn<SUIFRIENDS>(arg0, arg1);
    }

    fun init(arg0: SUIFRIENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRIENDS>(arg0, 6, b"suiFriends", b"Sui Friends Collection", b"Twitter: @SuiFriends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1654143406073937928/5Q3IzSoS_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFRIENDS>>(v1);
        0x2::coin::mint_and_transfer<SUIFRIENDS>(&mut v2, 550000000000000, 0x2::address::from_u256(58454181676832651002995437026903612124529456210016632369742661304833019219144), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRIENDS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFRIENDS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFRIENDS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

