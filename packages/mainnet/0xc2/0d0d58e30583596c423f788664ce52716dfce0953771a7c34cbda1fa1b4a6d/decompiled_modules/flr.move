module 0xc20d0d58e30583596c423f788664ce52716dfce0953771a7c34cbda1fa1b4a6d::flr {
    struct FLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLR>(arg0, 6, b"FLR", b"SuiFlare", b"A blazing-fast utility token on the Sui Network, igniting on-chain activity and rewarding holders with flame-themed NFT drops and staking bonuses. Inspired by the little fire creature that lights up your ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifik3r35fighlm62q5ofv3y5g3nzocfiefecdz3xejxirquqkolmi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

