module 0x539871f3364732dc7fb08847542015a2b0d2e1e49ccf933782ecefe5bcd42735::suiwen {
    struct SUIWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEN>(arg0, 6, b"SUIWEN", b"Sui Wen", b"Amazing wen culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7564_d06e436148.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

