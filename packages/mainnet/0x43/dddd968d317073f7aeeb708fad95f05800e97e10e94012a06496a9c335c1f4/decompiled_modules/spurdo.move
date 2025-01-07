module 0x43dddd968d317073f7aeeb708fad95f05800e97e10e94012a06496a9c335c1f4::spurdo {
    struct SPURDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPURDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPURDO>(arg0, 6, b"SPURDO", b"Spurdo", b"SPURDO IS DA TRU OG MEME AND FINALLY REEDY TO SHAKE DE SPACE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_862d70c09d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPURDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPURDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

