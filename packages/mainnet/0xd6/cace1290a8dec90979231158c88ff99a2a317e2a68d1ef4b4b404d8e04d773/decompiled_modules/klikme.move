module 0xd6cace1290a8dec90979231158c88ff99a2a317e2a68d1ef4b4b404d8e04d773::klikme {
    struct KLIKME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLIKME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLIKME>(arg0, 6, b"KLIKME", b"Klikmecoin", b"Only klikme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmf3vv5zoeffubxri2wce6j7u2tqbx2f2wgi5bz3pzyij2s3otnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLIKME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLIKME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

