module 0x2647bb02897da2312e79b8edf5b837c2b4ff2b821ea33191ef9dd3a4e8960d36::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 6, b"Dolphin", b"Dolphin with a hat", b"Just a dolphin with a hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dolphin_wearing_a_purple_party_hat_ardea_9a89872e50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

