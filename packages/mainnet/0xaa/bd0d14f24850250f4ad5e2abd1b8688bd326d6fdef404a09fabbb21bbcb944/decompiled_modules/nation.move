module 0xaabd0d14f24850250f4ad5e2abd1b8688bd326d6fdef404a09fabbb21bbcb944::nation {
    struct NATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATION>(arg0, 6, b"NATION", b"NATION", b"NATION ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737713813380-AGN.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NATION>>(v1);
        0x2::coin::mint_and_transfer<NATION>(&mut v2, 1000000000 * 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NATION>>(v2);
    }

    // decompiled from Move bytecode v6
}

