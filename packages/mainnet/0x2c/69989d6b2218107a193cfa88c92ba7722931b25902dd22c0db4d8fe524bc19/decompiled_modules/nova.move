module 0x2c69989d6b2218107a193cfa88c92ba7722931b25902dd22c0db4d8fe524bc19::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 9, b"NOVA", b"NovaLink Token", b"Bridging off-chain data and on-chain ecosystems on Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://novalink.network/nova.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOVA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

