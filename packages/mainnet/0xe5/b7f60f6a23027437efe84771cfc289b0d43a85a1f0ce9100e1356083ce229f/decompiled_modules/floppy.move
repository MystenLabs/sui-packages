module 0xe5b7f60f6a23027437efe84771cfc289b0d43a85a1f0ce9100e1356083ce229f::floppy {
    struct FLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPY>(arg0, 6, b"FLOPPY", b"Floppy Sui", b"$FLOPPY on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FAQ_53221c7358.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

