module 0x55215289714ce28e215d4375c7b98409649018673cc41ca42492d58dd7cc7bbf::genies {
    struct GENIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIES>(arg0, 6, b"GENIES", b"Sui genie", b"$GENIES a meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000498_f68d102e8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

