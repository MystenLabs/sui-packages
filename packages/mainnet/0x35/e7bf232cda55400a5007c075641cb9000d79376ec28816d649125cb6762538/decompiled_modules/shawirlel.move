module 0x35e7bf232cda55400a5007c075641cb9000d79376ec28816d649125cb6762538::shawirlel {
    struct SHAWIRLEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWIRLEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWIRLEL>(arg0, 6, b"Shawirlel", b"Shawir", b"Eh oui donnez", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/def12305a72fefc082956dfa6844fa32_26448852b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWIRLEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWIRLEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

