module 0x2b51ab8486927c42b057ca7adecd9bc0880789e47bb05d80f491d01890ec9d11::notebook {
    struct NOTEBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTEBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTEBOOK>(arg0, 6, b"NOTEBOOK", b"THE NOTEBOOK", b"A Real Love Story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250202_020932_216_2d4fa90871.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTEBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTEBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

