module 0x4457ac59f1bad1d74c1585870f6c199bc6c659aadbb77015855a1d888790ee1a::kappa {
    struct KAPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPA>(arg0, 6, b"KAPPA", b"KAPPA COIN", x"4265666f726520636f696e732c206265666f726520636861696e732c207468657265207761732077617465722e0a0a576174657220616e642061206d696768747920596f6b61693a204b617070612e0a0a456f6e73206f66206d69736368696566207061737365642e2e2e0a0a4e6f77207472616e73666f726d656420696e746f2063727970746f6772617068696320687964726f2d70686f746f6e732e0a0a4869732053617261206973206c6f61646564207769746820706f7765722c20726561647920746f20626520756e6c656173686564206f6e205355492e0a0a53756920537a6e206973207368696674696e672e2041726520796f752072656164793f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7bt5vx7f35gk2stw72nef5ejwdajeagtoz5sxj6c6c2w3b4bi7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAPPA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

