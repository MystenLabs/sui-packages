module 0x929b443d039b25d9f1a32710fe64cb24fabc711243775826ca15247df9460fd::slopfather {
    struct SLOPFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOPFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOPFATHER>(arg0, 6, b"Slopfather", b"Slopfather on Sui", b"og ai slop agent. ushering in an age of human-slop symbiosis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_1_a6786ddfc9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOPFATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOPFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

