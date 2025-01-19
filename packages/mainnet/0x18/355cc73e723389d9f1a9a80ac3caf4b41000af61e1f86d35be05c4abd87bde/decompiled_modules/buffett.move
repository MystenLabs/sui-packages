module 0x18355cc73e723389d9f1a9a80ac3caf4b41000af61e1f86d35be05c4abd87bde::buffett {
    struct BUFFETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFETT>(arg0, 9, b"BUFFETT", b"OFFICIAL BUFFETT COIN", b"Community-driven Warren $BUFFETT meme coin created to conquest the market's world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNXjscKfnuhxxkDYK2MbFJ8KDEm7kzTVG18ELzSRThQ4p")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUFFETT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUFFETT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFETT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

