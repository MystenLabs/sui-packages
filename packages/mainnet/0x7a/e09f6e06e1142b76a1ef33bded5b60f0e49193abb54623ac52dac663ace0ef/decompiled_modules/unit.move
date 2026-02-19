module 0x7ae09f6e06e1142b76a1ef33bded5b60f0e49193abb54623ac52dac663ace0ef::unit {
    struct UNIT has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<UNIT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT> {
        0x2::coin::mint<UNIT>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT>>(0x2::coin::mint<UNIT>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT>, arg1: 0x2::coin::Coin<UNIT>) {
        0x2::coin::burn<UNIT>(arg0, arg1);
    }

    fun init(arg0: UNIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT>(arg0, 9, b"EMBER", b"Ember Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-6kw_a52AhD.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

