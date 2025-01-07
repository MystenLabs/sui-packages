module 0x4317342c8da1485589a4f9fab05ccc3766292571cdc3905afe97c72ae3d450a3::atter {
    struct ATTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTER>(arg0, 6, b"Atter", b"Atter", b"Atter IS A ALTERNATIVE FOR OTTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWan2U68Gfd26hbb2Whs3MoR3oKsFsbsvvMLkTxJafM14?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ATTER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTER>>(v2, @0x767f87e69f459fed1a24377fcecbd3272ffe7360721b0f9da2b38dfb21ce534d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

