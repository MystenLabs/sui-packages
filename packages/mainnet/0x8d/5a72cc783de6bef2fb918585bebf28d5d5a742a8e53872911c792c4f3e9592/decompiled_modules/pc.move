module 0x8d5a72cc783de6bef2fb918585bebf28d5d5a742a8e53872911c792c4f3e9592::pc {
    struct PC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PC>(arg0, 6, b"PC", b"Pussy Cat", b"it is only a pussy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmU4pS1GEgP8pLCKFPvfHsCVxEgFNqkhxAjWKYjb1J29ft?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PC>>(v2, @0x27eb87bc7371821110b327089a81a5af9ae33235fcd63784cb90a2d11bc25f5d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PC>>(v1);
    }

    // decompiled from Move bytecode v6
}

