module 0x78be30f10f41de7dc8d7c6e6d8a6b829bcdf940d8e8439ba74265828ec74e482::pluflo {
    struct PLUFLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFLO>(arg0, 6, b"Pluflo", b"PlufloSui", b"Pluflo for fun memes and a vibrant community. Dont miss it,  join the excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_013513_3cdf776c29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

