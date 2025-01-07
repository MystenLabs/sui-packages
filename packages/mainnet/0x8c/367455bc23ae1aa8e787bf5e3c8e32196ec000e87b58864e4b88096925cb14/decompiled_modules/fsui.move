module 0x8c367455bc23ae1aa8e787bf5e3c8e32196ec000e87b58864e4b88096925cb14::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUI>(arg0, 6, b"FSUI", b"FOMO", b"FOMO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065036_66faf4dc56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

