module 0x767dccf398b121476269717e8157d2d558d0547031973ec08e04125faea8121d::cf {
    struct CF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CF>(arg0, 6, b"CF", b"Coffin Fish", b"The Coffinfish carves its existence beneath the waves, specifically in the saline embrace of the southwestern sui Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coffin_c24cda91e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CF>>(v1);
    }

    // decompiled from Move bytecode v6
}

