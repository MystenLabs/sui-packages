module 0x2b5e70d2bf29c98a94ccf845d809f39906f696285c22e2b0fc4130f887c72da::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"SUI ON SUI", x"535549204f4e20535549204953205448452046495253542053554920544f4b454e204f4e2054484520535549204e4554574f524b20544841542057494c4c20464f4c4c4f57205448452053554920544f4b454e0a0a5355492057494c4c205355490a5355492057494c4c205355490a5355492057494c4c205355490a5355492057494c4c205355490a5355492057494c4c205355490a5355492057494c4c20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaf3zi6j4eckahl3t2brqtyj2atfjhb4jpcuyvymllrqotkvlq34e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

