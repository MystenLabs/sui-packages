module 0xef75b88f5684f0b6442b2ecff71a13f4c7b880972c33a0c3af6794cf2526e52b::suiwoof {
    struct SUIWOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOOF>(arg0, 9, b"SWOOF", b"SUIWOOF", b"Woof Woof Woof !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreibkr2drhnne4opc6tnwinvm7rpefsnaxgli7mvcgcncdzuhzqlr2m.ipfs.nftstorage.link"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWOOF>>(v1);
        0x2::coin::mint_and_transfer<SUIWOOF>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUIWOOF>>(v2);
    }

    // decompiled from Move bytecode v6
}

