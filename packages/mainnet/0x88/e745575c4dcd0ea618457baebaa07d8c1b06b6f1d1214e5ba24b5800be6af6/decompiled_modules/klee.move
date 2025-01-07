module 0x88e745575c4dcd0ea618457baebaa07d8c1b06b6f1d1214e5ba24b5800be6af6::klee {
    struct KLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLEE>(arg0, 6, b"KLEE", b"KleeKaiSui", b"Its about time we name the Klee pup!  Want to have your legacy in web3 gaming solidified!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/keeka_cc27e82855.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

