module 0x60f185f8d2ffa88fac8acaa4b00c942dd075e77c69a1496b519a5d2a53948c5b::smurfe {
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

