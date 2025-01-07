module 0x344c9cff75db63c8f0667453de33468360b983a85005d205b8b2c582fe94d66a::mfc {
    struct MFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFC>(arg0, 6, b"MFC", b"Money For Criminals", b"The coin that flips the script on politicians who call crypto \"money for criminals.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mfc_71e9848b93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

