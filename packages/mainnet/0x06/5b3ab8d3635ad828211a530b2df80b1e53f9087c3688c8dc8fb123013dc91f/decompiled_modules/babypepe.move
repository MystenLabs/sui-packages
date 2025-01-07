module 0x65b3ab8d3635ad828211a530b2df80b1e53f9087c3688c8dc8fb123013dc91f::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BABYPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYPEPE>>(arg0, arg1);
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"BABYPEPE", b"BABYPEPE", b"BABYPEPE is the new blueChip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/MIAFjhu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYPEPE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

