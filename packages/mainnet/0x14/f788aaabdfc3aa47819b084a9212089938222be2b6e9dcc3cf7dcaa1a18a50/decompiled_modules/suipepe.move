module 0x14f788aaabdfc3aa47819b084a9212089938222be2b6e9dcc3cf7dcaa1a18a50::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: 0x2::coin::Coin<SUIPEPE>) {
        0x2::coin::burn<SUIPEPE>(arg0, arg1);
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"@suipepeofficial", b"Twitter: @suipepeofficial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1651974308409884672/0vfT-R7k_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::coin::mint_and_transfer<SUIPEPE>(&mut v2, 250000000000000, 0x2::address::from_u256(64118830154537302403150903442187064611355386484903641353949656248553320336673), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

