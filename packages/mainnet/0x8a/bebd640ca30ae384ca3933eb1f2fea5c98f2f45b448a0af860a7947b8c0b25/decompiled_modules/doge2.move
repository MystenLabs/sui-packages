module 0x8abebd640ca30ae384ca3933eb1f2fea5c98f2f45b448a0af860a7947b8c0b25::doge2 {
    struct DOGE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE2>(arg0, 6, b"DOGE2", b"Doge 2.0", b"$DOGE2.0 offers a second chance to invest in an ecosystem poised for explosive growth. Get ready for long-term gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040939_e3766ea7f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE2>>(v1);
    }

    // decompiled from Move bytecode v6
}

