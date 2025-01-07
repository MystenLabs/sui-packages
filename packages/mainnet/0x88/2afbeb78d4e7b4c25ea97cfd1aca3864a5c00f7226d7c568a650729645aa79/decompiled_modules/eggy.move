module 0x882afbeb78d4e7b4c25ea97cfd1aca3864a5c00f7226d7c568a650729645aa79::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 6, b"EGGY", b"Eggycoin on sui", b"$EGGY, more than just a Meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038894_a0b7d1b406.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

