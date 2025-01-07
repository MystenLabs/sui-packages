module 0xbe556331ff596a554905ac4a0805ea82ef65977b143f131c3455533017580024::gonke {
    struct GONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONKE>(arg0, 6, b"GONKE", b"Gonke", b"Yo, swag seekers and street stylists! Meet GONKE, the epitome of gangsta ponke vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_09_26_51_5a81685e71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

