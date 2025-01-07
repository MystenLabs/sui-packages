module 0x6b382fdd1298a719da2b951233b06ba0b9bed53541590d395f3029175d56cf37::sonke {
    struct SONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONKE>(arg0, 6, b"SONKE", b"SONKE SUI", b"Woooooooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t4o_Yn_F8j_400x400_73317de969.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

