module 0x1f27a1a9453b5577b436a07fe5656091f1ad8c6e10af876696a549535b6e12b::moro {
    struct MORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORO>(arg0, 9, b"MORO", b"robo", b"this collection was created especially to celebrate the success of talentum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bff6255a6baaa0db82e277bd8ecf15cbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

