module 0xfcf0b0edb766bdcb719c87e322570902b8ea78df76f646bbfd756448e4725543::captainofsui {
    struct CAPTAINOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPTAINOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPTAINOFSUI>(arg0, 6, b"Captainofsui", b"Sui shield", b"Sui shield ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906257_a6611c8a07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPTAINOFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPTAINOFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

