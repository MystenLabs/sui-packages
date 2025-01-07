module 0x472495a7841b4d3c9dfd13188a45180d03bb98c46c32ebbb802a6f6112c0f7a3::gigatrump {
    struct GIGATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGATRUMP>(arg0, 6, b"GIGATRUMP", b"Giga Trump Pepe", b"Giga Trump Pepe got shot in the ear.  Got Epic Photo.  Fight.  Win Election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_A_p_ad3f450f76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

