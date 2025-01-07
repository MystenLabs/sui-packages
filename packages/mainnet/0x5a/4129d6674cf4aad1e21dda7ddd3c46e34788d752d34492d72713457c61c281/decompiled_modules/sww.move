module 0x5a4129d6674cf4aad1e21dda7ddd3c46e34788d752d34492d72713457c61c281::sww {
    struct SWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWW>(arg0, 6, b"SWW", b"Stop WW3", b"Stop WW3 Please", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raf_360x360_075_t_fafafa_ca443f4786_u2_42b8cb81ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

