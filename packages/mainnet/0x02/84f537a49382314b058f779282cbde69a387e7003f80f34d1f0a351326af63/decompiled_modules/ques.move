module 0x284f537a49382314b058f779282cbde69a387e7003f80f34d1f0a351326af63::ques {
    struct QUES has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUES>(arg0, 9, b"QUES", b"No question", b"Got a question? Keep to yourself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/0958f53e3b842d6b43e9dfb83eea49e2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

