module 0xd3b4dbfab518c7c57740b21783871e81894a50e25609cb6a235baea15a236017::protocol_803 {
    struct PROTOCOL_803 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_803>, arg1: 0x2::coin::Coin<PROTOCOL_803>) {
        0x2::coin::burn<PROTOCOL_803>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_803>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_803> {
        0x2::coin::mint<PROTOCOL_803>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_803>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_803>>(0x2::coin::mint<PROTOCOL_803>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROTOCOL_803, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_803>(arg0, 9, b"BUT", b"Bucket Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-DZctYy7jsM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_803>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_803>>(v1);
    }

    // decompiled from Move bytecode v6
}

