module 0x9496d23b86b0753d4e33034712318790068948e91af1b4c7693fb3df9f60b822::stt {
    struct STT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STT>(arg0, 6, b"STT", b"sui terrorist", b"BOMB the CHART", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaas_6f8fc2ef8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STT>>(v1);
    }

    // decompiled from Move bytecode v6
}

