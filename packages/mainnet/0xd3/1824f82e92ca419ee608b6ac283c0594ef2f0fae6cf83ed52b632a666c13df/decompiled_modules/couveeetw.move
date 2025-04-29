module 0xd31824f82e92ca419ee608b6ac283c0594ef2f0fae6cf83ed52b632a666c13df::couveeetw {
    struct COUVEEETW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUVEEETW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUVEEETW>(arg0, 9, b"Couveeetw", b"couveee", b"abaewewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fee794c29acbbfec58da533fa4291719blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COUVEEETW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUVEEETW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

