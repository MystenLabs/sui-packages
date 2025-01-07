module 0x7ccc8f7e5f5612b0859a2f936f5e6e76c5f6ddeb7fab41e61806c5a77dd94b11::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWE>(arg0, 6, b"WWE", b"Wrestling", b"Do you like the show? you are us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmeG5YkQjuY8vuTbYXWZhcHDjHRxVQEVFSpGsybvKUTcKV?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WWE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWE>>(v2, @0x256e8b04003bb68641c82dffcb3ad0bced2735da7c3b5d36046c2b8c3df1ea9a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

