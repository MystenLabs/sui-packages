module 0x2343c8a32c87a1c86016ac0bf11139dce086eadd55a39581cb3424325bc6a4d5::mamalofi {
    struct MAMALOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMALOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMALOFI>(arg0, 6, b"MamaLofi", b"LoveofLofi", b"Devs are from Fartcoin  and buttcoin. Let's send this to millions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735971955525.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMALOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMALOFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

