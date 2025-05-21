module 0xafe0915cc99d97883c1971e6d8b94316e048ca8b1242fb71f300085fb066bb0c::ldragon {
    struct LDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDRAGON>(arg0, 6, b"LDRAGON", b"LitcDragon", b"Introducing Dragon On Sui!  the little dragon will be the new icon on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5mxdqps6h5zlevp7yfmlfedngaq5tvchbnyhmpmkgrrq7s4joqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDRAGON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

