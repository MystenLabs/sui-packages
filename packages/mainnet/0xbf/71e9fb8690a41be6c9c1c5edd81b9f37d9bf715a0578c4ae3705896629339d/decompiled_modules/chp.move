module 0xbf71e9fb8690a41be6c9c1c5edd81b9f37d9bf715a0578c4ae3705896629339d::chp {
    struct CHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHP>(arg0, 0, b"CHP", b"Chimp coin", b"Lucky Chimp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JRRevxj.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CHP>(&mut v2, 1000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHP>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

