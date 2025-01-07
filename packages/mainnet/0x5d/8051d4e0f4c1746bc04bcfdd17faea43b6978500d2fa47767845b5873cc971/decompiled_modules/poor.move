module 0x5d8051d4e0f4c1746bc04bcfdd17faea43b6978500d2fa47767845b5873cc971::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"Poor", b"Poor", b"we all have experienced it at least once in our life :')", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmdvyZdk3F7sUXwJyJ65s15h61KkN8mofs1nbszMv9W7u9?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v2, @0xe94222e6487784b3dad09fde1a7965ae8e473625e55e90d5609b4cc561d36fa2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

