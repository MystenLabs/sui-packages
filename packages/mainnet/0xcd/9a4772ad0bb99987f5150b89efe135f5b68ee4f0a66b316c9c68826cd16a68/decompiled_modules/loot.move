module 0xcd9a4772ad0bb99987f5150b89efe135f5b68ee4f0a66b316c9c68826cd16a68::loot {
    struct LOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOT>(arg0, 6, b"LOOT", b"LETS ROOT", b"Lets root", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiewgcqjfp5lruxjh2hlhsj67awp6ctd53ou45w57kgxfcuvf6vd2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

