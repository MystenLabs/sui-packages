module 0x5d5dfce63092e1b7a4ac1c9216af42a4ca7f0382432b0d9cc8014edf24f6c4c3::suineiro {
    struct SUINEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEIRO>(arg0, 6, b"SUINEIRO", b"SUI NEIRO", x"4272696e67696e6720696e20616e20657468657265756d206e6172726174697665206f66204e6569726f20746f2074686520245355492065636f73797374656d0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_XC_Wpeb_400x400_d86242f481.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

