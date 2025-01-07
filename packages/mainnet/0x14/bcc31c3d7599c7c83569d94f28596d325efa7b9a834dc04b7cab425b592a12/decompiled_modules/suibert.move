module 0x14bcc31c3d7599c7c83569d94f28596d325efa7b9a834dc04b7cab425b592a12::suibert {
    struct SUIBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERT>(arg0, 6, b"SUIBERT", b"SuibertOnsui", b"Suibert is the brainiac every crypto family needs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000426_619ca56d0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

