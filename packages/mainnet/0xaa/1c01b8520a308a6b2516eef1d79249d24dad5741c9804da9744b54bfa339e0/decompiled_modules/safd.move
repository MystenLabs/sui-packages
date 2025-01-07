module 0xaa1c01b8520a308a6b2516eef1d79249d24dad5741c9804da9744b54bfa339e0::safd {
    struct SAFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFD>(arg0, 6, b"safd", b"ddd", b"asdfsadf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Sn39gQnsUz_Jua_o12NDlP8xLvFAOEU_41KdWSC4Nuk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFD>>(v2, @0xaf77ec629b79245a0309b3a7184a1afc1f9ec8407b396d73688e1c97b22aff1e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

