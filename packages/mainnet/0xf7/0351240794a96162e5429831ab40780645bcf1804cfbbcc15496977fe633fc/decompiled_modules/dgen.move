module 0xf70351240794a96162e5429831ab40780645bcf1804cfbbcc15496977fe633fc::dgen {
    struct DGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGEN>(arg0, 9, b"DGEN", b"Degen The Otter", b"The world's first otter backed coin, officially supported by Degen's owner!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXcSgVmvWnbRk3dzZWBLKwXHmjEZSpqGGNkRqEavmULjd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DGEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

