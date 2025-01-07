module 0x6a814c7de64501c4fa98bdd817fc682fee88392e3b766c7fc988cb4c6698d7ff::rope {
    struct ROPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROPE>(arg0, 6, b"ROPE", b"SUIcide", b"pls dont crash sui or ill have to an hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmNbjPDMy7r6CCRjcLW3VpTG3hqNsF1dcn1mnuNreGCAyo?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROPE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROPE>>(v2, @0x6d8d6cbba2c993e8f290ca7121efea0f3f9bae8a4f7cd25554905a08ee3e53eb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

