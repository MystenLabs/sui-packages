module 0x59865eda0a1463aaca0ebe584fb91bf4ae37b5af1e136342fb3698913f099cbf::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 6, b"REKT", b"Meme in REKT", b"Got REKT in memecoin? Yeah, just REKT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000172551_2929daca8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

