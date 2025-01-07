module 0x75770102579e01ba4401ab38185e884563d99d75f8def504d572fff3688fb5ab::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 6, b"KERMIT", b"SuiKermit", b"The Greatest Frog Character of All Time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ou_G0_Rs_Td_400x400_7a9594daf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

