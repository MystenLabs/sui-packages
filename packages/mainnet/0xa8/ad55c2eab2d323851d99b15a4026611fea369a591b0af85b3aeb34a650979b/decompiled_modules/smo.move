module 0xa8ad55c2eab2d323851d99b15a4026611fea369a591b0af85b3aeb34a650979b::smo {
    struct SMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMO>(arg0, 6, b"SMO", b"Suilor moon", b"Suilor ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035719_1d1d24e526.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

