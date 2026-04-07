module 0x6407b2866df0c899518ae617f714c94165f88a43936e845a44118e6ebcc18691::main_40d {
    struct MAIN_40D has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<MAIN_40D>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MAIN_40D> {
        0x2::coin::mint<MAIN_40D>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<MAIN_40D>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN_40D>>(0x2::coin::mint<MAIN_40D>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MAIN_40D>, arg1: 0x2::coin::Coin<MAIN_40D>) {
        0x2::coin::burn<MAIN_40D>(arg0, arg1);
    }

    fun init(arg0: MAIN_40D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_40D>(arg0, 9, b"CETUS", b"Cetus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-2XQlgGQUe4.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MAIN_40D>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_40D>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

