module 0x1922fe3beed659ec89f372519cff203d3fdd57f5492c05a3ff79b3f311a52bb2::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"SUISHIB", b"The largest gathering of the Shiba Inu ecosystem to date", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/544495_D2_B088_4336_AC_88_2201792_A1293_bd05860137.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

