module 0x7fc41e9310e22b10208a768fc83174189506269514910cc861321a39c6c5e6d7::swow {
    struct SWOW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWOW>, arg1: 0x2::coin::Coin<SWOW>) {
        0x2::coin::burn<SWOW>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SWOW>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOW>>(arg0, @0x0);
    }

    fun init(arg0: SWOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOW>(arg0, 6, b"SWOW", b"Sui WOW", b"nice wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcTd0MzRhd3dhbHJwYTIwM3lpMG42YzF0czM0Y2FsaHJrZGljdXEwdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/vNe3lHwYeodgsFuiiE/giphy.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWOW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

