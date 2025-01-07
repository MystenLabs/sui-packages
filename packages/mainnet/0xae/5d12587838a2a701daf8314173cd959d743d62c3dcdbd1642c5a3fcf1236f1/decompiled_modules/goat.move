module 0xae5d12587838a2a701daf8314173cd959d743d62c3dcdbd1642c5a3fcf1236f1::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"Goatseus Maximus", b"GOAT", b"GOAT (Goatseus Maximus) is a meme token on the Sui blockchain. Join the herd and embrace the glory of GOAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR373JkTf1ppgqBzDC8sgEY38rJ1CjH4VsRbSAJ7ih5i8")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

