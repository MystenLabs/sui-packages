module 0x5b9a111e718347aafcc248887ab3a7c27919aeb073a6639baf27bce7a4605701::based {
    struct BASED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASED>(arg0, 6, b"BASED", b"Make America based again", b"Time for America to be based again - join the movement with Elon Musk's Make America Based Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8dfa5bd198.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASED>>(v1);
    }

    // decompiled from Move bytecode v6
}

