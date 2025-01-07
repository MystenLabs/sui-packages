module 0x7c142f39e262dce06d8ef8e1752113b923e75c8c75b1e795ccd75396cf8d7d78::Token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"NEIRO", b"NEIRO Token", b"Unlock the Power of Web3 with the Simplicity of Web2! | All in One #Multichain, #SocialFI , #GameFI, #Launchpad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gold-molecular-mollusk-268.mypinata.cloud/ipfs/QmYCZBCFsYA9H6Mdh7M3DpLWZLTFD8UVC6ofYb3CfwHsgD"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000000, @0xf1c831a889f5745f630278b51e4f91e420cdcd1694dbcc3ab3d6d2bb786a4bb0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

