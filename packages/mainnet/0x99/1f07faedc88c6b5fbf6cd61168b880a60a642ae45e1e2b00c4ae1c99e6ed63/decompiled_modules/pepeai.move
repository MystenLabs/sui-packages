module 0x991f07faedc88c6b5fbf6cd61168b880a60a642ae45e1e2b00c4ae1c99e6ed63::pepeai {
    struct PEPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEAI>(arg0, 9, b"PEPEAI", b"Pepe Ai Sui", b"Pepe Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.dexlab.space/file/db3d0c3d03d2416a9eab8a6a342af9cd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPEAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

