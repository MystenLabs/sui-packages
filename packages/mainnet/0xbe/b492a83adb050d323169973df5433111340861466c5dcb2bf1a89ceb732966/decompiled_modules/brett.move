module 0xbeb492a83adb050d323169973df5433111340861466c5dcb2bf1a89ceb732966::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"BLUE SUI BRETT", x"205355492042524554540a546865207665727920666972737420244272657474206f6e20537569206e6574776f726b0a427265747420697320746865206c6567656e64617279206368617261637465722066726f6d204d6174742046757269657320426f79732720636c756220636f6d69632e20486520686173206265636f6d652074686520626c7565206d6173636f74206f66207468652053756920636861696e2e0a0a200a2054473a2068747470733a2f2f742e6d652f53756942726574745f5375690a20583a2068747470733a2f2f782e636f6d2f42726574745f537569436861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3713_3ab4bbe2b3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

