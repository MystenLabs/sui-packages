module 0x86246b0fea127b3e6e35e9f0e70a1d5b211da192d2e09444899aee4b57b5908f::suifarm {
    struct SUIFARM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIFARM>, arg1: 0x2::coin::Coin<SUIFARM>) {
        0x2::coin::burn<SUIFARM>(arg0, arg1);
    }

    fun init(arg0: SUIFARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFARM>(arg0, 9, b"suifarm", b"sfarm", b"t.me/suifarmtrend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/YeLNvLe.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFARM>>(v1);
        0x2::coin::mint_and_transfer<SUIFARM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFARM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFARM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFARM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

