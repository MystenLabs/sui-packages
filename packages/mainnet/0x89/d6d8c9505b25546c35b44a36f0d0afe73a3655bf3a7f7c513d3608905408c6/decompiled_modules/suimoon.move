module 0x89d6d8c9505b25546c35b44a36f0d0afe73a3655bf3a7f7c513d3608905408c6::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 6, b"Suimoon", b"SuiMoon", b"New path, same safe destination...  Straight to the Moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_1244730780072350_aa2e7e2d2b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

