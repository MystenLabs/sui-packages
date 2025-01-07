module 0xe92040050fff9ae7a6a0285ac6df5b5839924dcc9c77b4fb1f8306af4eb711ad::smurfe {
    struct SMURFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFE>(arg0, 6, b"SMURFE", b"Smurfe", b"Small in size, big on memecoin dreams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Smurfe_Logo_82bf60c639.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

