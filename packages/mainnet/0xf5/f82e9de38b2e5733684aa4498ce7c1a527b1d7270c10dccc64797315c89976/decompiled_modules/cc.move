module 0xf5f82e9de38b2e5733684aa4498ce7c1a527b1d7270c10dccc64797315c89976::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CC>, arg1: 0x2::coin::Coin<CC>) {
        0x2::coin::burn<CC>(arg0, arg1);
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 7, b"CC", b"KLARNA CARD (VR+PHYSICAL)", x"4b4c41524e41204341524420285649525455414c205245414c495459202b20504859534943414c29207469636b65723a2043432e20c2a9efb88f4b4c41524e41c2aeefb88f20323032362d323039362e205745205345525645205448452047454e4552414c205055424c494320414e4420415245204e4f54204c4941424c4520464f52204c4f53542046554e4453204f52204c41434b204f4620534552564943452044554520544f20434f4d505554455220474c4954434845532e2057452f49202f55532f414e59204f46204f5552205041494420574f524b455253204f522053554220434f4e54524143544f525320415245204e4f54204c4941424c4520464f52204c4f53542044415441204f5220554e415641494c41424c4520414e414c59544943532046524f4d204341524453204f52205452414e53414354494f4e5320484953544f52592e204e4f204c415753554954532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifdtldyvmlhdblgchopdhtrqy4lr2ktes7uqit45eln47ugp7dkbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

