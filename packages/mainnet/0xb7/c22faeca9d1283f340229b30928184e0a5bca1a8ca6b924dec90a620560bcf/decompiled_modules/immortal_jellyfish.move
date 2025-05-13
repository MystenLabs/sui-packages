module 0xb7c22faeca9d1283f340229b30928184e0a5bca1a8ca6b924dec90a620560bcf::immortal_jellyfish {
    struct IMMORTAL_JELLYFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMMORTAL_JELLYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 761 || 0x2::tx_context::epoch(arg1) == 762, 1);
        let (v0, v1) = 0x2::coin::create_currency<IMMORTAL_JELLYFISH>(arg0, 9, b"JELLY", b"Immortal jellyfish", b"The one who never dies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmZDWhdwaoaBXXbmjeMMGyZ5kz7TYHCU28JdH7sKnv8RE7"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMMORTAL_JELLYFISH>(&mut v2, 1000000000000000000, @0x9a067588ad2acb59b56502d9632dd40a55bf9f75c93a9c203ceb0e0239c3c983, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMMORTAL_JELLYFISH>>(v2, @0x9a067588ad2acb59b56502d9632dd40a55bf9f75c93a9c203ceb0e0239c3c983);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMMORTAL_JELLYFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

