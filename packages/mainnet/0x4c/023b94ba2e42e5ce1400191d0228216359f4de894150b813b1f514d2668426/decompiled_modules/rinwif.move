module 0x4c023b94ba2e42e5ce1400191d0228216359f4de894150b813b1f514d2668426::rinwif {
    struct RINWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINWIF>(arg0, 6, b"RINWIF", b"rinwifhat", b"Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good, Rinwif is so good.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmUMrHW9c3S2GNSyX7LuDxk2ZU5wBGTzwo4D6xKvLCj5Sc?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RINWIF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINWIF>>(v2, @0xfbb44e2dab42f95ca442d7d6b693885495af3da79c25ced2d2111224976cb40);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RINWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

