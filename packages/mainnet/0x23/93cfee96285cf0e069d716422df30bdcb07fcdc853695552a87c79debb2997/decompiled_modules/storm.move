module 0x2393cfee96285cf0e069d716422df30bdcb07fcdc853695552a87c79debb2997::storm {
    struct STORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STORM>(arg0, 9, b"STORM", b"STORM", b"The devil said you cannot withstand the storm. The warrior replied, I AM THE STORM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeighodn64dfid5whrpogm5moadbohtkpwl4zkotowjyoq7dkeb4pji")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STORM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STORM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STORM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STORM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

