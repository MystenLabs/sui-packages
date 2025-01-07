module 0x762fdcc6e0cc58dc29d5962e601f9f81a51b430276faa6662ce6cc75889dac4b::floppy {
    struct FLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPY>(arg0, 6, b"FLOPPY", b"Floppy Sui", x"24464c4f505059206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FAQ_e5cf838a40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

