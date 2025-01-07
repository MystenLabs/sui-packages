module 0xd150fb18a4c8c08d112a55c89830e8f74c308af852df7db6868d69201702f738::wifsuitsu {
    struct WIFSUITSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFSUITSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFSUITSU>(arg0, 6, b"WifSuitsu", b"Shih Tzu Wif Hat", x"0a0a0a0a0a0a20245769665375697473752069732074686520666972737420616e64206f6e6c79205368696820547a75206f6e207468652053756920636861696e2c20726561647920746f20636861726d2074686520776f726c64207769746820686973207369676e61747572652068617420616e642074616b6520796f75206f6e20616e20756e666f726765747461626c65206a6f75726e657921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241015_081636_c8f247543b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFSUITSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFSUITSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

