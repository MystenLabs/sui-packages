module 0x1a4b57ee950696303be91f5c2ef6c78ea5e29a4d91d4cfd306276ee30a8d8c5b::nchanglian {
    struct NCHANGLIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCHANGLIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCHANGLIAN>(arg0, 6, b"NChangLian", b"301618", b"NChangLian 301618", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_f82dc12559.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCHANGLIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCHANGLIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

