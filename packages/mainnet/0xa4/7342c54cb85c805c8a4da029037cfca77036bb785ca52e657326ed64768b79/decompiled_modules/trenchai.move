module 0xa47342c54cb85c805c8a4da029037cfca77036bb785ca52e657326ed64768b79::trenchai {
    struct TRENCHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHAI>(arg0, 9, b"TrenchAI", b"Trenches AI", x"5472656e636865732041490d0a0d0a416e2041492d64726976656e2074726164696e67206167656e74206f6e207468652053554920626c6f636b636861696e2c206275696c7420666f72207365616d6c657373206d656d6520636f696e20747261636b696e672c20616e616c797369732c20616e6420736d6172742074726164696e672e200d0a0d0a466173742c207363616c61626c652c20616e642064657369676e656420666f7220646567656e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmam3rZwwQve6dxTaBKc7vQCfAU1rWAqATFY28K7Zcq8ef")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRENCHAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRENCHAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

