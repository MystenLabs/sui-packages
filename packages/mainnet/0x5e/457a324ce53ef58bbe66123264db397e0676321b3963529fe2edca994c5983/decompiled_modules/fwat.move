module 0x5e457a324ce53ef58bbe66123264db397e0676321b3963529fe2edca994c5983::fwat {
    struct FWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWAT>(arg0, 6, b"FWAT", b"Fwog cat", b"If you fade my dog fwog coin $wog, you cant fade $wat <3 let the games begin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726367838587_fe6ad5293c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

