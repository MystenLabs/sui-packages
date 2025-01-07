module 0xb940b318070a0927d652a0fa17a1e4b41eb45d38207b520865789340904b2805::METEORA {
    struct METEORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: METEORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METEORA>(arg0, 9, b"METEORA", b"METEORA", b"METEORA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.meteora.ag/icons/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METEORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METEORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<METEORA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<METEORA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

