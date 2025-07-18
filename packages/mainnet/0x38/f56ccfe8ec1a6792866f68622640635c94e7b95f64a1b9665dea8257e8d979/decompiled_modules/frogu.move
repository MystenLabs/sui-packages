module 0x38f56ccfe8ec1a6792866f68622640635c94e7b95f64a1b9665dea8257e8d979::frogu {
    struct FROGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGU>(arg0, 9, b"FROGU", b"Frogu", b"Hopping onto the next trend! Frogu brings spring-loaded gains and keeps your portfolio ribbit-ing with energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6pow52dtdeq4m6xoxpvrkeuaah5r3ne7net44753zbpb24z7wvi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROGU>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

