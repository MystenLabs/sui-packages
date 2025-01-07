module 0xf10c2f3b82082a052fb2195d0fcabcc8cbab2daf9856c2985b3dcb11b2752bcc::ilj {
    struct ILJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILJ>(arg0, 6, b"ILJ", b"iLoveJesus", b"I love Jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWUmUmhw1UgdH4SpjTV3QBgKxndogFZ5CZHsTPU3Jwk28?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILJ>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILJ>>(v2, @0x334081cc8047fcaba66110fe52fcffe5df9024f0b75d77f92c4188618f322376);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

