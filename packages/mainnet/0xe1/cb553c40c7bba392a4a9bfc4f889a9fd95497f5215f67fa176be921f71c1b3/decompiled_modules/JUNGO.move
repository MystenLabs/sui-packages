module 0xe1cb553c40c7bba392a4a9bfc4f889a9fd95497f5215f67fa176be921f71c1b3::JUNGO {
    struct JUNGO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JUNGO>, arg1: 0x2::coin::Coin<JUNGO>) {
        0x2::coin::burn<JUNGO>(arg0, arg1);
    }

    fun init(arg0: JUNGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNGO>(arg0, 9, b"JUNGO", b"Jun Go", b"Ryan Coin Demo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/5jWKz7h/JunGo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUNGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUNGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

