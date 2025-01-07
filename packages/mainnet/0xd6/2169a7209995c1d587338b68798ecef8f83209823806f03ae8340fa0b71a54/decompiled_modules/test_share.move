module 0xd62169a7209995c1d587338b68798ecef8f83209823806f03ae8340fa0b71a54::test_share {
    public fun change_coin_metadata_to_shared<T0>(arg0: 0x2::coin::CoinMetadata<T0>) {
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

