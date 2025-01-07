module 0xb6d32e90083e3af3b302d5cfc72b64ab852b3cced58cffa74ffcb4b8feea4f8e::idogesui {
    struct IDOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDOGESUI>(arg0, 6, b"IDOGESUI", b"ISLAND DOGE SUI", b" Introducing Island Dog Token - The Ultimate Beachside Pup of Crypto! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_00_37_24_634b5ef3dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

