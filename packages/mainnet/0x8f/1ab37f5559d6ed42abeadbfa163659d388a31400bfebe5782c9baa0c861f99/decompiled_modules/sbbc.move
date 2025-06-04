module 0x8f1ab37f5559d6ed42abeadbfa163659d388a31400bfebe5782c9baa0c861f99::sbbc {
    struct SBBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBBC>(arg0, 6, b"SBBC", b"Sui buy bot club", b"Buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiflgh5q6e33ub64j7jtjkads44megiyfujimekxnr5tqjc66ghrtq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBBC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

