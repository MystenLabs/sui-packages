module 0x154d06aac88ce767c70193c3cd5cf669bcfee43805e23121c64aaccb499fedba::miyajima {
    struct MIYAJIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIYAJIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIYAJIMA>(arg0, 6, b"MIYAJIMA", b"Miyajima", b"MiyajimaPublic Aquarium", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241010023501_8898a6d721.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIYAJIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIYAJIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

