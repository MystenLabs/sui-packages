module 0x5710a102eb0a55ab04377b7b157c8233c45b1dbb147051b0b6e780e3807bfd94::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"Bluey", b"Blueysui", b"The bluest dog on sui. Elon likes it , bezos will take it to space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000018148_6d55976f4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

