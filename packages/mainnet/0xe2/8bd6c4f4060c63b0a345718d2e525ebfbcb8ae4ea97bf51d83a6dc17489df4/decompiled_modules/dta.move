module 0xe28bd6c4f4060c63b0a345718d2e525ebfbcb8ae4ea97bf51d83a6dc17489df4::dta {
    struct DTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTA>(arg0, 6, b"DTA", b"Dogtheftauto", b"Dogtheftauto is here, hop in and join the gang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2467_7eca68452f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

