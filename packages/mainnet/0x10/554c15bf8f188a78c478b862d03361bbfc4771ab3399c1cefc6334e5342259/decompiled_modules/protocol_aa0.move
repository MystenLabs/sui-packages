module 0x10554c15bf8f188a78c478b862d03361bbfc4771ab3399c1cefc6334e5342259::protocol_aa0 {
    struct PROTOCOL_AA0 has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_AA0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_AA0> {
        0x2::coin::mint<PROTOCOL_AA0>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_AA0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_AA0>>(0x2::coin::mint<PROTOCOL_AA0>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_AA0>, arg1: 0x2::coin::Coin<PROTOCOL_AA0>) {
        0x2::coin::burn<PROTOCOL_AA0>(arg0, arg1);
    }

    fun init(arg0: PROTOCOL_AA0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_AA0>(arg0, 9, b"EMBER", b"Ember Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-v1roZup2y5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_AA0>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_AA0>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

