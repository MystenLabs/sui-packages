module 0xbc7af9f62602823dcf48aad94467f2803c95f22aefbe9de7cec9810d9b384e3::messiah {
    struct MESSIAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSIAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSIAH>(arg0, 6, b"Messiah", b"Crypto Messiah", x"537569204368616420697320686572652c2063686164730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GW_Lx6ob_Wc_AA_Vpuu_e1102b8080.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSIAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSIAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

