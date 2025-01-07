module 0x87a3e55104b41cf5390a62c7ae64aec8f27308f59d16d514d6953a51b3858bc8::afdekbjefajk {
    struct AFDEKBJEFAJK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFDEKBJEFAJK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFDEKBJEFAJK>(arg0, 6, b"afdekbjefajk", b"khjdafkjefdahj", b"potato", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVeX8i5j54jMDL8iqT7JWC5jp5dytyaiuWfqyvPpw6zRR?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AFDEKBJEFAJK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFDEKBJEFAJK>>(v2, @0x9eb600f807122c94930db27911ba574334141faab341bb0c32cb01c6d771a4c6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFDEKBJEFAJK>>(v1);
    }

    // decompiled from Move bytecode v6
}

