module 0x1582440e09685747f3dea61db6046bfa69e9f50a18198ef1eac9fca1a92482a0::eagle {
    struct EAGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAGLE>(arg0, 6, b"EAGLE", b"Eagle Boy", b"$EAGLE IS A MEME PROJECT ON SUI BLOCKCHAIN END COMUNITY GROW UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/248o4n_74a83a4fb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EAGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

