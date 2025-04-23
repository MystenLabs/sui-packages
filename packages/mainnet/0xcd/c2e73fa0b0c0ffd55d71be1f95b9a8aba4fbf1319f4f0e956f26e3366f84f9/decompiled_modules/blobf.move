module 0xcdc2e73fa0b0c0ffd55d71be1f95b9a8aba4fbf1319f4f0e956f26e3366f84f9::blobf {
    struct BLOBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBF>(arg0, 6, b"BlobF", b"BlobFish", x"424c4f4246495348203a204c656170696e6720696e746f2074686520667574757265206f662041490a6f6e2074686520535549204e4554574f524b2e2057696c6c20746869732068797065640a6d656d6520636f696e2068656c7020796f7520686f7020746f20726963686573206f720a6c6561766520796f752063726f616b696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih3r7jqmos2iexngolvvlumhnno2mxtmsbdx6gega3n52huou3tqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOBF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

