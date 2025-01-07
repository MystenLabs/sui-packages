module 0x48ad60880cd7c351a2d7ad7c5d8b80b28464dbaa38ef69ce81db94b9ccc8b6e2::spm {
    struct SPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPM>(arg0, 6, b"SPM", b"SUIPERMAN", b"CTO meme coin, dev no buy first, community based. TG: t.me/suipeman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_227f4a0815.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

