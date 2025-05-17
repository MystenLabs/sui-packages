module 0xa8999a0d9888337c9b47dc4ad23beaba7e7566f1be4b11eaae64b0877c7fd765::moose {
    struct MOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSE>(arg0, 6, b"MOOSE", b"Moosen On Sui", b"MOOSE isn t just another meme coin its a fun, community-driven project on the Sui blockchain with staking rewards a DAO governance system and a roadmap full of exciting developments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifw55wg2ae36rwusr7asl4lhm6zhn4du6iwodvfw6rnrvqira2x7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOOSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

