module 0x7a2b50c6a3730ba3c87203097298239dab93ca05dd825b03be08f74efc664a8f::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 9, b"STONKS", b"STONKS on Sui", b"it's stonks time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSHW37vAK1F4Y6uUD76ZFzerih8DcV7KNMT2tQh5SP8fP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STONKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

