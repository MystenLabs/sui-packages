module 0xe28ff850e612462d25ca8977ce0c3d1eee9ace7a568be8a6f8a18f82490af985::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUING>(arg0, 6, b"Suing", b"Suing lawsuit", b"A suing lawsuit will be taken against any one who doesnt buy our Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4681_C4_BC_5_C30_4407_A5_C4_11509_B420_F0_B_829a4e9240.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUING>>(v1);
    }

    // decompiled from Move bytecode v6
}

