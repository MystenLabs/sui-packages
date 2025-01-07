module 0x7bcb6d1c2a71c313b9426425ff5feada2ed469fe848b435e53e99b41c458e2d3::hey {
    struct HEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEY>(arg0, 6, b"Hey", b"Hey", b"Hey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXUYyozdS8nWFJNju64y98WzXpHCqiJ4cYLrkNKS14u6h"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HEY>>(v2);
    }

    // decompiled from Move bytecode v6
}

