module 0xedc8a3b85f6c1c7461b87ac88f1c9b4552ddabdda094070174e59a9f8ab73cdb::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 6, b"ASUI", b"AmongSui", b"Hey, I'm Blue from \"Among Us.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UIMBA_6317208c04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

