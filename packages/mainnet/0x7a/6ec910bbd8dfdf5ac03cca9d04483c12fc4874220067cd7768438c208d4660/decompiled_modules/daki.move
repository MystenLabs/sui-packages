module 0x7a6ec910bbd8dfdf5ac03cca9d04483c12fc4874220067cd7768438c208d4660::daki {
    struct DAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAKI>(arg0, 6, b"DAKI", b"im DAKI the girlfriend of $DAK", b"I'm DAKI the girlfriend of $DAK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9241daa4_42b6_4790_88d3_0beaa2f60c1a_ca6014134d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

