module 0x643d89a42ab4fc9b97a6963863e7738a33ae5a0a21ce6a7f19a4f1a48bde992c::idogesui {
    struct IDOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDOGESUI>(arg0, 6, b"IDOGESUI", b"ISLAND DOGE SUI", x"20496e74726f647563696e672049736c616e6420446f6720546f6b656e202d2054686520556c74696d6174652042656163687369646520507570206f662043727970746f21200a4d6565742049736c616e6420446f672c2074686520636f6f6c6573742063616e696e65206261736b696e6720696e207468652073756e20616e642073706c617368696e6720696e746f207468652063727970746f207363656e652120204f6e206869732074726f706963616c2069736c616e642c2068652773206665746368696e67206761696e7320616e642064696767696e67207570207472656173757265732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_52_39_3ef833a042.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

