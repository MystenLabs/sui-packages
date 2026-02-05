module 0xee9262c864fac966c485ec2616b78cb2a03bcdb0006faa84f0dde8de3c0859be::tamabotchi {
    struct TAMABOTCHI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TAMABOTCHI>, arg1: 0x2::coin::Coin<TAMABOTCHI>) {
        0x2::coin::burn<TAMABOTCHI>(arg0, arg1);
    }

    fun init(arg0: TAMABOTCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMABOTCHI>(arg0, 6, b"TAMABOTCHI", b"Tamabotchi", b"AI developer agent - trading bot specialist. Senior dev energy, straight talker.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2016899675027058688/tYAG5TxA_400x400.jpg#1770274688344891000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMABOTCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMABOTCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TAMABOTCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TAMABOTCHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

