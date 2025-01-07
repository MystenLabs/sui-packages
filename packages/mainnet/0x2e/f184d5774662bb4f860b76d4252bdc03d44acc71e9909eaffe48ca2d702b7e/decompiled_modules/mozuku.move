module 0x2ef184d5774662bb4f860b76d4252bdc03d44acc71e9909eaffe48ca2d702b7e::mozuku {
    struct MOZUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZUKU>(arg0, 6, b"MOZUKU", b"SUIMOZUKU", x"244d4f5a554b5520617320776520666f756e64206f75742c2069732074686520626972746820676976656e206e616d65206f662074686520776f726c642066616d6f757320646f67204b61626f7375207468617420696e7370697265642074686520444f4745206d656d65212057652077616e7420696d6d6f7274616c697a6520686973206d656d6f727920696e207468697320746f6b656e20616e6420696e7669746520796f7520746f206a6f696e20757321204f6e2074686973207061676520796f752063616e2066696e6420616c6c207468652070726f6f6620616e642070726f6a65637420696e666f20796f75206e656564212057656c636f6d65210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_43_715921dd40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

