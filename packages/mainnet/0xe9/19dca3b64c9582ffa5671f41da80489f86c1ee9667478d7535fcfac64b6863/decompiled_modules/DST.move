module 0xe919dca3b64c9582ffa5671f41da80489f86c1ee9667478d7535fcfac64b6863::DST {
    struct DST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DST>(arg0, 9, b"DST", b"DeSui Token", b"Unlock the Power of Web3 with the Simplicity of Web2! | All in One #Multichain, #SocialFI , #GameFI, #Launchpad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gold-molecular-mollusk-268.mypinata.cloud/ipfs/QmYCZBCFsYA9H6Mdh7M3DpLWZLTFD8UVC6ofYb3CfwHsgD"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DST>>(v1);
        0x2::coin::mint_and_transfer<DST>(&mut v2, 10000000000000000000, @0x5b02490e232e8848917819a95e49c4c4b60cfc1a14bfcbe500fb7dc0137e2940, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DST>>(v2);
    }

    // decompiled from Move bytecode v6
}

