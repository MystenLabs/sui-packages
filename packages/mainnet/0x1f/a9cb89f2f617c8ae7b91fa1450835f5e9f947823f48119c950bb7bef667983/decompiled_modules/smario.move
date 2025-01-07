module 0x1fa9cb89f2f617c8ae7b91fa1450835f5e9f947823f48119c950bb7bef667983::smario {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARIO>(arg0, 6, b"SMARIO", b"Suiper Mario", b"Meme inspired by the classic game Super Mario Bros...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024609_6994f0fb9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

