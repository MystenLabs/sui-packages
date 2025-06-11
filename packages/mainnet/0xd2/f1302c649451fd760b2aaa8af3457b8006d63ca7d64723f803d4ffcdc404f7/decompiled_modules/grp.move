module 0xd2f1302c649451fd760b2aaa8af3457b8006d63ca7d64723f803d4ffcdc404f7::grp {
    struct GRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRP>(arg0, 6, b"GRP", b"GiveRep", b"The reputation must flow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5ycsvjbsgbl2efuvn33gr6ftrk2wqicsuhnlzkc5zejletk3btu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

