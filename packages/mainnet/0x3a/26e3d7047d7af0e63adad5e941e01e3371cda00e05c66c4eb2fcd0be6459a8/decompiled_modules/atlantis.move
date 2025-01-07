module 0x3a26e3d7047d7af0e63adad5e941e01e3371cda00e05c66c4eb2fcd0be6459a8::atlantis {
    struct ATLANTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLANTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLANTIS>(arg0, 6, b"ATLANTIS", b"Atlantis on Sui", b"Welcome to Atlantis the land of the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_717a8aa8ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLANTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLANTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

