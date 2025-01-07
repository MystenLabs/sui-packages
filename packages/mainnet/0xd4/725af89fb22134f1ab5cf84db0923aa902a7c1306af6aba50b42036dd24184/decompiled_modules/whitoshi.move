module 0xd4725af89fb22134f1ab5cf84db0923aa902a7c1306af6aba50b42036dd24184::whitoshi {
    struct WHITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITOSHI>(arg0, 6, b"WHITOSHI", b"WHITOSHItoken", x"576869746f73686920697320612077686974652053686962612077686f2077696c6c206272696e67206e6577206c69666520746f2074686520646f676576657273652c20637265617465206e6577206578636974656d656e742c20616472656e616c696e652c20616e6420656e646f727068696e7320666f7220696e766573746f72732028484f4c44455253290a42555920414e4420484f4c44", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4quk_ZI_Zy_400x400_f94e31ed4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

