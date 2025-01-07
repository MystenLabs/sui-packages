module 0x13b6f7a7b4de3bcef197c6d131de4d17c413eb4d354dbc197282fe551e89d397::boli {
    struct BOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLI>(arg0, 6, b"Boli", b"Sui Boli", b"$Boli for the cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilupo_fc29e51903.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

