module 0x9f806b16a74df0554431a021e924995d74839612bac756e40da96fa6143c3dbe::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 6, b"WAGMI", b"Wagmi on Sui", b"Allow me to give credit to all of its users by launching a memecoins that I was already thinking about a month ago.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzrddhsb5pstqat2u33vkxempedgmvcpn3rfgs2nvlfogfhzbof4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAGMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

