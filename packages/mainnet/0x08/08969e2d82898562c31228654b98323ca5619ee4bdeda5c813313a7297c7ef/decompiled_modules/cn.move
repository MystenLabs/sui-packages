module 0x808969e2d82898562c31228654b98323ca5619ee4bdeda5c813313a7297c7ef::cn {
    struct CN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CN>(arg0, 6, b"CN", b"SUI", x"41726520796f75207469726564206f662074686520666f726569676e65727327206361747320616e6420646f6773207a6f6f204d454d4520636f696e2063756c747572653f0a57652073686f756c642062652070726f756420746f207361792c204920616d204368696e6573652c2049206c6f7665204368696e612c20616e64207765206e65656420746f20756e69746520746f2077656c636f6d6520666f726569676e657273206361727279696e6720736564616e2063686169727321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_1835871788_3645403362_and_fm_253_and_fmt_auto_and_app_120_and_f_JPEG_030cb01b62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CN>>(v1);
    }

    // decompiled from Move bytecode v6
}

