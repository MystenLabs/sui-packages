module 0x822e1df6ddfbda0a17f8e80e33282445f9642c0d23b7fa954ef8fcb72882ee3::scallop_wormhole_eth {
    struct SCALLOP_WORMHOLE_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_ETH>(arg0, 8, b"sWETH", b"sWETH", b"Scallop interest-bearing token for wormhole ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nwghzgql25ptojnx5nf4mwb7i7wbg5hfyb573tx4iit5iqwdrz4q.arweave.net/bYx8mgvXXzclt-tLxlg_R-wTdOXAe_3O_EIn1ELDjnk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

