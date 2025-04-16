module 0x5df2dbcace078f6a0ada04cfac61687c60cb677b406cab6d5ceee5024ca9350b::stg_08 {
    struct STG_08 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_08, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_08>(arg0, 6, b"STG_08", b"STG_08", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.dextools.io/resources/tokens/logos/solana/4Y7y8SBHF2ZGfM9FiTqDuunWzPjCNJ4npYSqmgKQpump.jpg?1744767198943"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_08>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_08>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_08>>(v2);
    }

    // decompiled from Move bytecode v6
}

