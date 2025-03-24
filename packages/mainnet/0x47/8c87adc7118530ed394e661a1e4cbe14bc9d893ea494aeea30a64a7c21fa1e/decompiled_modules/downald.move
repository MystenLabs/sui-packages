module 0x478c87adc7118530ed394e661a1e4cbe14bc9d893ea494aeea30a64a7c21fa1e::downald {
    struct DOWNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWNALD>(arg0, 9, b"Downald", b"Downald Trump", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXu8LE1w5uvhkxrEUjpTdW4tNS32B9EyaorYgzsnnBFGL")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOWNALD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOWNALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWNALD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

