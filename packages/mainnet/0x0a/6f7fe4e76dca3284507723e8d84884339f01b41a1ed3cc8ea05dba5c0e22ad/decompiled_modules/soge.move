module 0xa6f7fe4e76dca3284507723e8d84884339f01b41a1ed3cc8ea05dba5c0e22ad::soge {
    struct SOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGE>(arg0, 6, b"SOGE", b"SOGE SUI", x"534f474520204f6666696369616c20446f6765206f66205355492e0a534f47452c20696e73706972656420627920746865206c6567656e6461727920446f67652c2069732074686520446f67652076657273696f6e206f6e207468652053554920626c6f636b636861696e2e204372656174656420776974682074686520676f616c206f66206e6f74206f6e6c7920706f70756c6172697a696e6720746563686e6f6c6f677920616d6f6e67206120776964652061756469656e63652062757420616c736f20756e6974696e67207468652063727970746f63757272656e637920636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soge256_085f194101.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

