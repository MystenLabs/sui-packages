module 0xbf761c2fd274f856fa97faa03e5ebcc534e6d406c08f7131b41706f76c61994::suinei {
    struct SUINEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEI>(arg0, 6, b"SUINEI", b"NEI ON SUI", x"4d494c414459204e454920464f52205355490a0a20436f6d6d756e69747920697320686f6d652c2077686572652077652062656c6f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidwj7s6awiafzi2pggr3s7x5nipk55q6l272evgxkl4b4mf7fcn4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINEI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

