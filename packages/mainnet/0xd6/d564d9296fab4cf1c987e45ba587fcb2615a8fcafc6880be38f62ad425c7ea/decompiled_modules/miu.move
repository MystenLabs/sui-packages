module 0xd6d564d9296fab4cf1c987e45ba587fcb2615a8fcafc6880be38f62ad425c7ea::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIU>, arg1: 0x2::coin::Coin<MIU>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MIU>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIU>>(0x2::coin::mint<MIU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MIU>(arg0, 9, b"MIU", b"MIU", x"4d495520e28094206375746520636174206d656d6520636f696e206f6e205375692e204d656f7720746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://miucoin.org/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MIU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MIU>>(v0);
    }

    // decompiled from Move bytecode v6
}

