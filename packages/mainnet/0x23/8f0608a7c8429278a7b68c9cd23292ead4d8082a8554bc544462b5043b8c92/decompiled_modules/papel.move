module 0x238f0608a7c8429278a7b68c9cd23292ead4d8082a8554bc544462b5043b8c92::papel {
    struct PAPEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPEL>(arg0, 6, b"Papel", b"PapelonSui", b"Papel - lets do it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000815_2970e20262.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

