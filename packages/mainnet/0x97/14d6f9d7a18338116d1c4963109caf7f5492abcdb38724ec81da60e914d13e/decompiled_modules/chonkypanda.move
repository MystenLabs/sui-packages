module 0x9714d6f9d7a18338116d1c4963109caf7f5492abcdb38724ec81da60e914d13e::chonkypanda {
    struct CHONKYPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKYPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKYPANDA>(arg0, 9, b"CHONKY", b"ChonkyPanda", x"546865206f6e6c792062656172206d61726b657420796f75276c6c206c6f76652e2043686f6e6b7950616e6461206c6f756e6765732c206d756e636865732c20616e64206a757374207669626573e2809470726f6669747320636f6d6520746f2074686f73652077686f206368696c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreie657dc2r52yxdwjnoa7jrblasejurn67qny7gfv52vdstccvxsr4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHONKYPANDA>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKYPANDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKYPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

