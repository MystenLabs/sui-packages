module 0x38b32afea851c83b75c0d4f5a8e3992fd91a7cca2b4d78c6fdf984e9f9cee091::suicatc {
    struct SUICATC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATC>(arg0, 6, b"SuiCatC", b"Sui Cat C", b"Sui Cat C  is the next big meme coin on the Sui Network! Price surges and growing liquidit-ymassive partnerships coming soon! Dont miss out on the profits-join the Sui Cat C community now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_buddha_f75144bdd6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATC>>(v1);
    }

    // decompiled from Move bytecode v6
}

