module 0x3672f44cd1bb93cd06777df9443d91d577cbd9213f0e51e01bd7132f181a6e91::whisc {
    struct WHISC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISC>(arg0, 6, b"WHISC", b"Whiskerino the Cat", b"Whiskerino the Disapprover is a small, fluffy cat with an expressive, almost permanently furrowed brow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/caaaatttt_320959788a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISC>>(v1);
    }

    // decompiled from Move bytecode v6
}

