module 0x724d89037fb068cee61585f48c05eb7457a8326aec320c69eebf0232b6570524::suiup {
    struct SUIUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUP>(arg0, 9, b"SUIUP", b"Sui-Up", x"41726520796f7520726561647920746f20736f61722068696768207769746820616e20696e6372656469626c652063727970746f20616476656e747572653f0d0a5355492d55502069732061206d656d6520746f6b656e20696e737069726564206279207468652066616d6f757320506978617220616e696d617465642066696c6d2055702e0d0a57697468205355492d55502c20796f7520776f6e2774206a757374206a6f696e2061206361707469766174696e672063727970746f206a6f75726e65792c0d0a62757420616c736f2067657420746865206368616e636520746f20656d62726163652074686520737069726974206f6620616476656e7475726520616e642068617070696e6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNwn6pEPPJRGaJx4evXtnkyWvdWcnWusMXaK36xATMTr5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIUP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

