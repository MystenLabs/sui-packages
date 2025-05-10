module 0x7faa3fc13f26b471d81742715881e087911b57a77d0d2f612e680d2e17d3ee09::mynx {
    struct MYNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYNX>(arg0, 9, b"MYNX", b"Quake", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4792d86a905f1bdf631f1faa41f02fdeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYNX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYNX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

