module 0xf7bba699c71c70f4f7bd9ee83f09f880af3115679ba499a60e78742063b6f53f::goaat {
    struct GOAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAAT>(arg0, 9, b"Goatseus Maximus", b"GOAT", b"GOAT (Goatseus Maximus) is a meme token on the Sui blockchain. Join the herd and embrace the glory of GOAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR373JkTf1ppgqBzDC8sgEY38rJ1CjH4VsRbSAJ7ih5i8")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAAT>>(v1);
        0x2::coin::mint_and_transfer<GOAAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOAAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

