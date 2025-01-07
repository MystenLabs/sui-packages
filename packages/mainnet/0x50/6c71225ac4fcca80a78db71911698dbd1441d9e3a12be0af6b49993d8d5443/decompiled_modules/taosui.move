module 0x506c71225ac4fcca80a78db71911698dbd1441d9e3a12be0af6b49993d8d5443::taosui {
    struct TAOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOSUI>(arg0, 6, b"TAOSUI", b"UNCLE TAOSUI", x"54686520756e696669636174696f6e206f66205361746f736869204e616b616d6f746f7320616e642042697474656e736f727320647265616d206f6620646563656e7472616c697a6174696f6e206f6e205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0w_Ye_Bcj3_400x400_c993d8005a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

