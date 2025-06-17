module 0x9a5c3873c67b392dc21a5b7ecfe44ba2c2c17669e9f561f0423f5314a8b33eda::zchu {
    struct ZCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZCHU>(arg0, 6, b"ZCHU", b"AuraChu", b"Electric clout. SUI native. No roadmap, just shocks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibclahqaqhrwdrwsk4bmud7ll2izv4f2wnweyhysdumpzderhb3je")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

