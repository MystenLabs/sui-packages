module 0x451be067d23d4c431f4c81c0ea2e6c29471a26925b58bea9889043336cc5bd2e::ustd {
    struct USTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USTD>(arg0, 6, b"USTD", b"Teter", b"To won dollah u degeneraz, the new meta is here, and is ours, together united to make history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_b7b5ad4e00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

