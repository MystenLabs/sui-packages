module 0x3136abab06f09a5af91dcf916204319b2546679d28bdf6f24121b8e6613e43fd::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE", b"An army responsible for the revolution on the Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002405931_80d5cfa1e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

