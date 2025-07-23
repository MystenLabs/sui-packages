module 0x1d693893755cbeb8755e57a88d1c4b34deb7608f995e66449bb60c4a16559bd5::bkasui {
    struct BKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKASUI>(arg0, 6, b"BKaSui", b"Banjo KaSui", x"42616e6a6f204b615375692069732061206e6f7374616c676963206d656d652d636f696e20616476656e74757265206f6e207468652053554920626c6f636b636861696e2c20696e737069726564206279207468652069636f6e69632062656172202620626972642064756f2066726f6d20726574726f2067616d696e67206c6567656e64732e0a4e6f20726f61646d61702e204e6f2070726573616c652e204a7573742070757265206d656d6520706f77657220616e6420636f6d6d756e6974792076696265732e0a4a6f696e2074686520726964652c20636f6c6c6563742070757a7a6c65207069656365732c20616e642068656c7020244b61535549206563686f207468726f756768207468652057656233206a756e676c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid4bgenwffxlma2ynveyt3rudctcywdwc453xht4ujjercrptcxte")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BKASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

