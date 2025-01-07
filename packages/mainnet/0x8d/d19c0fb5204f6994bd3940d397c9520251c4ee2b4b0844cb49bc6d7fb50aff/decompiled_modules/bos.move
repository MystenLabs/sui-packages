module 0x8dd19c0fb5204f6994bd3940d397c9520251c4ee2b4b0844cb49bc6d7fb50aff::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 9, b"BOS", b"Book of sui", b"A Journey into Decentralized Innovation on SUI Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t.me/bookofsuiofficial")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

