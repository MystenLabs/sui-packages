module 0x59f3ed8afb8c22fd81936e63edc95321b13e54d10ec65c7458cbd9eb0e9b9908::CAPOSUI {
    struct CAPOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOSUI>(arg0, 9, b"CAPOSUI", b"CAPOSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPOSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPOSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPOSUI>>(0x2::coin::mint<CAPOSUI>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

