module 0xd5f56774d93cba18799e6afb6821081588daed600ac8279ada621e244bfa8e36::suipox {
    struct SUIPOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOX>(arg0, 6, b"SUIPOX", b"Sui Pox", b"$SUIPOX is a memecoin with a unique concept, inspired by the infamous upcoming \"Monkey Virus\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_27da7757ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

