module 0x2ea15c483e554dda6a461673b4a109f70c71abd1296d40a9deba9a94a9470ce6::suinda {
    struct SUINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDA>(arg0, 6, b"SUINDA", b"SUINDAQUIL", b"suinda-suinda!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/155_CON_FONDO_fbc79c0afe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

