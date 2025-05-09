module 0x5b71d7890412145f99be1e489ef0ff467d9f633b0f256a938bff965cc759040a::dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 6, b"DEX", b"POKEDEX ON SUI", x"506f6b6564657820547261636b657220697320612063757474696e672d6564676520706c6174666f726d206275696c74206f6e207468652053756920626c6f636b636861696e2c2064657369676e656420746f2068656c7020506f6bc3a96d6f6e20656e74687573696173747320747261636b20616e6420636174616c6f67207468656972204e465420636f6c6c656374696f6e732077697468206120726574726f2c20706978656c617465642061657374686574696320696e73706972656420627920636c617373696320506f6bc3a96d6f6e2067616d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab3irmgksklippz7vh5ryr7dhqmn2u7xvnn5cfxymjmqgbro52qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

