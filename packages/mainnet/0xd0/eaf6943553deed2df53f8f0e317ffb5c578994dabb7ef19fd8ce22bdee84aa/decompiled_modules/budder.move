module 0xd0eaf6943553deed2df53f8f0e317ffb5c578994dabb7ef19fd8ce22bdee84aa::budder {
    struct BUDDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDER>(arg0, 6, b"BUDDER", b"Budder Dawg", b"Meet Butterscotch Shiba, the furry phenomenon born from Peargor's creative genius. Starting as the star of the viral \"No Mutt November\" video, Butterscotch quickly won hearts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_0381abf7c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

