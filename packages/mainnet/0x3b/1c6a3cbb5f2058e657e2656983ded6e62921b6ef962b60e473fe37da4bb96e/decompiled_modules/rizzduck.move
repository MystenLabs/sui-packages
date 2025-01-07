module 0x3b1c6a3cbb5f2058e657e2656983ded6e62921b6ef962b60e473fe37da4bb96e::rizzduck {
    struct RIZZDUCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RIZZDUCK>, arg1: 0x2::coin::Coin<RIZZDUCK>) {
        0x2::coin::burn<RIZZDUCK>(arg0, arg1);
    }

    fun init(arg0: RIZZDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZDUCK>(arg0, 9, b"RIZZDUCK", b"RizzDuck", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1868939128298930176/N9bkrJJV_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIZZDUCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RIZZDUCK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

