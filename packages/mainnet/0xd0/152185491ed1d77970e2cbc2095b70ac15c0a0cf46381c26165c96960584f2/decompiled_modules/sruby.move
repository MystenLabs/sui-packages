module 0xd0152185491ed1d77970e2cbc2095b70ac15c0a0cf46381c26165c96960584f2::sruby {
    struct SRUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUBY>(arg0, 6, b"SRUBY", b"SUIRUBY", x"2046616972206c61756e63682070726f6a656374206f6e207468652053756920626c6f636b636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_Iz_VE_Dh_400x400_6612d0290a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

