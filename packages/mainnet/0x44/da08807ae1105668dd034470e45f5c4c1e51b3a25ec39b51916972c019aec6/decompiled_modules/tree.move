module 0x44da08807ae1105668dd034470e45f5c4c1e51b3a25ec39b51916972c019aec6::tree {
    struct TREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREE>(arg0, 9, b"Tree", b"beautiful tree", b"beautiful flower ot the tree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/421d68f714c02329267834940cb28324blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

