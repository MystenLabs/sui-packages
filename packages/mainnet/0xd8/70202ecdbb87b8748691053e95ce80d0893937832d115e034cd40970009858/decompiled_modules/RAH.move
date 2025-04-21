module 0xd870202ecdbb87b8748691053e95ce80d0893937832d115e034cd40970009858::RAH {
    struct RAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAH>(arg0, 6, b"RAH", b"eye of rah", b"heyyo what is this eye of rah???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmXrCrXjnGszJCqf3cACSYmLcUq2dV5PM7HCbFsseVBQ41")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

