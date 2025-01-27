module 0x3a66587e720c96fcb4227672adfa391a51317c44d5b404af77be131e960ba2a0::elz {
    struct ELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELZ>(arg0, 9, b"ELZ", b"Eliza", b"This is Eliza AI token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWFMxwHWjBqx1k1jqMFUn9D8Hfm5WHMVTRBTvaio1qYbu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELZ>>(v2, @0x617474e158b7657ffae118c63c60c6e79d6522b36e81d4dd471e75692c926f81);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

