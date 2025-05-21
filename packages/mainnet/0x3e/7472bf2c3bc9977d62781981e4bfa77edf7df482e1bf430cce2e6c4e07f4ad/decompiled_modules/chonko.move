module 0x3e7472bf2c3bc9977d62781981e4bfa77edf7df482e1bf430cce2e6c4e07f4ad::chonko {
    struct CHONKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKO>(arg0, 6, b"Chonko", b"Sui Chonko Dile", b"Big belly, bigger gains!\" The chonkiest gator on $SUI too heavy to dump, too lazy to rug! No roadmap, just vibes and moonshots!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigqw5fkjk5ptypjk2hupbrmixvudnr2howvx5c4hlaxdrqff3ogmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHONKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

