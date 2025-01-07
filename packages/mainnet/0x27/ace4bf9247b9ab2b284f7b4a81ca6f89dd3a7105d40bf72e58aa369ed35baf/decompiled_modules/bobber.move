module 0x27ace4bf9247b9ab2b284f7b4a81ca6f89dd3a7105d40bf72e58aa369ed35baf::bobber {
    struct BOBBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBBER>(arg0, 6, b"Bobber", b"Sui Bobber", b"Bbr, kurwa! Ja pierdol, jakie bydl! Bbr! Ej, kurwa, bbr! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bbober_527be0f64b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

