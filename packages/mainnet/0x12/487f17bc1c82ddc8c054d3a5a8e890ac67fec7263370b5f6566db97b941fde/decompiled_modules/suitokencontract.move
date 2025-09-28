module 0x12487f17bc1c82ddc8c054d3a5a8e890ac67fec7263370b5f6566db97b941fde::suitokencontract {
    struct SUITOKENCONTRACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOKENCONTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOKENCONTRACT>(arg0, 9, b"SI", b"SUITOKEN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-blushing-woodpecker-143.mypinata.cloud/ipfs/Qmed2qynTAszs9SiZZpf58QeXcNcYgPnu6XzkD4oeLacU4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITOKENCONTRACT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOKENCONTRACT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITOKENCONTRACT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITOKENCONTRACT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

