module 0x9c94352ef2bde1b64886a1f05fc61c2a97dd8eebb2f51d70c903445aa58ae4c3::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 6, b"RRR", b"testing", b"this test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib53sbk4sphbcdnpjx6sfovi5n7r4xbrbxcrkbuonhhtgqf3rtxfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RRR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

