module 0xb021c0b9f8d149af6cb7f81d6d1a69b0bf9ddaa755bcf073d02c31bfa368a799::BOSS {
    struct BOSS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOSS>, arg1: 0x2::coin::Coin<BOSS>) {
        0x2::coin::burn<BOSS>(arg0, arg1);
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 2, b"BOSS", b"BOSS", b"BOSS on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/bsc/0xc50c46214339b87218247803b23961612e28d7ff.jpg?1683628401536")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOSS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOSS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

