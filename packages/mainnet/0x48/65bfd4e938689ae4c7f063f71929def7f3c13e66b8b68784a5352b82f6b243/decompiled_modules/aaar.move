module 0x4865bfd4e938689ae4c7f063f71929def7f3c13e66b8b68784a5352b82f6b243::aaar {
    struct AAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAR>(arg0, 6, b"AAAR", b"AAAARAT ON SUI", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_95bac4a3cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

