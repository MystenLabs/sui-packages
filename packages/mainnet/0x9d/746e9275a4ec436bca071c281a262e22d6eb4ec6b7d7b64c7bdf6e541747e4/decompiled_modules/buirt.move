module 0x9d746e9275a4ec436bca071c281a262e22d6eb4ec6b7d7b64c7bdf6e541747e4::buirt {
    struct BUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUIRT>(arg0, 6, b"Buirt", b"BUIRT SIMPSON", x"4255495254203a2042617274206f6e207468652053554920576174657220426c6f636b636861696e200a0a596f2c20496d2042554952542c20426172742053696d70736f6e732077696c642076657273696f6e206f6e207468652053554920626c6f636b636861696e2e0a204475682c2049206472616e6b20746f6f206d756368207761746572202e0a204d79206269672062656c6c793f20426c616d65206974206f6e205355492076696265732e0a0a5363686f6f6c3f204920686174652069742e200a43727970746f3f205468617473206d79206a616d20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3366_00ab8c7946.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

