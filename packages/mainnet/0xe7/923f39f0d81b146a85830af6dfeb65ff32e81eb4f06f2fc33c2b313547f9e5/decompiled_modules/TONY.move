module 0xe7923f39f0d81b146a85830af6dfeb65ff32e81eb4f06f2fc33c2b313547f9e5::TONY {
    struct TONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TONY>>(v0);
    }

    public fun mint(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<TONY>, 0x2::coin::CoinMetadata<TONY>) {
        let (v0, v1) = 0x2::coin::create_currency<TONY>(arg0, 9, b"TONY", b"Tony The Sniper Malone", b"Tony \"The Sniper\" Malone is here to clean up scams and restore trust in crypto memes. Join the Bambino Family and be part of the revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lime-yodelling-possum-195.mypinata.cloud/ipfs/QmNZ1gYJFRDgnzvoPMtfi5Q2wkD6TevmP3tEJg4cpj8nV2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONY>(&mut v2, 1000000000 * 1000000000 / 10000 * 8000, @0x3a427490dc0d6edbb0429110242107dc7165e1cc525e8c6c21960e0228c06aa2, arg1);
        0x2::coin::mint_and_transfer<TONY>(&mut v2, 1000000000 * 1000000000 / 10000 * 1500, @0x8b65bf72a8d2022d29a18308606b282f7ccc16daf651bfbb04b2c8c6844ae5b1, arg1);
        0x2::coin::mint_and_transfer<TONY>(&mut v2, 1000000000 * 1000000000 / 10000 * 500, @0xb252cabf3486c1d4fb957b68ada64fcf6af521bf7e00ed5f0f769fb995132a3d, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

