module 0x7d15bf3f48f5e2d8fbb3670115e9eab2181029bcec5db8115f725500051a2cf4::dis {
    struct DIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIS>(arg0, 6, b"DIS", b"Dis", b"Disney Chain (DIS) is an innovative proof-of-work (PoW) public blockchain that integrates meme culture and AI computational technology. It strives to establish a stable, efficient and decentralized blockchain ecosystem for its users and developers. Through collaborative efforts from its community and miners, it has undergone a significant merged upgrade to enhance network performance and foster community engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmanLEKGiQrZNxF9DNEabLWuCjHU6KrYEc1KG2QC1YTtuC?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIS>>(v2, @0x7784ee46191859bc3ecd64de6023866ec7c50f4831be0be5370d28a1bb260dc8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

