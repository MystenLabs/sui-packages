module 0xc35143ea8a845f3078074229767d1f46a76fcad224d8987cdc3c7827bcf994e6::kfk {
    struct KFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFK>(arg0, 6, b"KFK", b"Kung Fu Kangaroo", x"4275696c64696e6720544845206669676874696e672067616d65206f6e200a407375696e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid7lc46fzbuyrrpqspvfavnl3cj7vj57gvjvhtvne77awrshhhx5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KFK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

