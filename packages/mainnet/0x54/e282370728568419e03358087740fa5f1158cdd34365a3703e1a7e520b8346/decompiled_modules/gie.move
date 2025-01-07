module 0x54e282370728568419e03358087740fa5f1158cdd34365a3703e1a7e520b8346::gie {
    struct GIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIE>(arg0, 6, b"GIE", b"Genie", b"Blue Genies Memes is a fun, creative project mixing humor and magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_074a613db0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

