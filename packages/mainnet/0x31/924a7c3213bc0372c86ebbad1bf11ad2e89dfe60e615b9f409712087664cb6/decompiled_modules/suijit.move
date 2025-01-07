module 0x31924a7c3213bc0372c86ebbad1bf11ad2e89dfe60e615b9f409712087664cb6::suijit {
    struct SUIJIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIT>(arg0, 6, b"SUIJIT", b"Pranav Suijit", b"hi good ser im pranav suijit operating on the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_ea968842b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

