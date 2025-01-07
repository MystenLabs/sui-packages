module 0xce2054a9a4efa4405fb1e8152c231a096aa4bb846fa1e2b9a8889736f51274f2::komasui {
    struct KOMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMASUI>(arg0, 6, b"KomaSui", b"Koma Sui", b"Komasui on Fire!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1401_74908553a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

