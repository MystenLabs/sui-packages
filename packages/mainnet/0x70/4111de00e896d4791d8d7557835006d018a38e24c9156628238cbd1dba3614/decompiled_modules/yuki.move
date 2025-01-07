module 0x704111de00e896d4791d8d7557835006d018a38e24c9156628238cbd1dba3614::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"YUKI", b"Samurai Cat SUI", b"From the tranquil gardens of the samurai's mind, where cherry blossoms whisper secrets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_6c6cad0fb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

