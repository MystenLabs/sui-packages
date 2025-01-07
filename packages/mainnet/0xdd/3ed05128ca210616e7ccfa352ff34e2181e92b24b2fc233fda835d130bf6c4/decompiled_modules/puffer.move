module 0xdd3ed05128ca210616e7ccfa352ff34e2181e92b24b2fc233fda835d130bf6c4::puffer {
    struct PUFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFER>(arg0, 6, b"PUFFER", b"Puffer Finance", b"We are excited to announce our cross chain collaboration with Sui! Bringing financial inclusion to the masses! Please checkout our social links for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puffer_6abe1b903e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

