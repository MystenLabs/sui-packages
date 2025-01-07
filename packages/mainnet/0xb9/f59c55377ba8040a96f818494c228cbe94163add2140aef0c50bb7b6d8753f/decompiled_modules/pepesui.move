module 0xb9f59c55377ba8040a96f818494c228cbe94163add2140aef0c50bb7b6d8753f::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPESUI>, arg1: 0x2::coin::Coin<PEPESUI>) {
        0x2::coin::burn<PEPESUI>(arg0, arg1);
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 2, b"PEPES", b"PEPE SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ssI98A0.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPESUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::supply_value<PEPESUI>(0x2::coin::supply<PEPESUI>(arg0)) < 42000000000000000, 1);
        0x2::coin::mint_and_transfer<PEPESUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun transferOwnership(arg0: 0x2::coin::TreasuryCap<PEPESUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

