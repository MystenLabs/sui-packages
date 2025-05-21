module 0x40402a987c2f8a71b755561bfbd16c2cbb991e27e609ad148809491c32bacab9::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KUI>, arg1: 0x2::coin::Coin<KUI>) {
        0x2::coin::burn<KUI>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KUI>>(0x2::coin::mint<KUI>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<KUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<KUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<KUI>(arg0, 6, b"KUI", b"Kui on SUI", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://img.upanh.tv/2025/05/21/iEQ114Jn51qU76Y-2Adn1PUH55WdUhrDpA75Ow1nfgMd-RukYSKgcgqhZJWrhRITpVFv0gLSXkQ6RjdrtTLwQZoVm4PdwB_u7XYHYH5QxaaJIOwm7RaHUEyIyCFejzY-Rhc5il-EWJFdvR8rJiC3nwL4Knyx2d652HN5Qfad-pzYfRSeVXpl9r3-5QLvS5mTR2vZABkY.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<KUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<KUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<KUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

