module 0xe82075a4f218209bd56c4ad0ed35dd4de7b73c803340d97750ace7b832fd3f3b::SEP {
    struct SEP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SEP>, arg1: 0x2::coin::Coin<SEP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SEP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEP>>(0x2::coin::mint<SEP>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SEP>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SEP>>(arg0);
    }

    fun init(arg0: SEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEP>(arg0, 9, b"SEP", b"Sui Eater Protocol", b"Let SEP consume your Sui and reward you with more Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_6850b08f4977b1.38717211.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

