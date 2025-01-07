module 0x562ccb432b3b7512f6ac52b06ba403c753ab395754669d32aff47dee482bff14::amk {
    struct AMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMK>(arg0, 6, b"AMK", b"AMENOMIKUMARINOKAMI", b"Japanese water goddess (SUI). As a god who distributes water, he was also the subject of prayers for rain, and those worshiped at water sources were also noted as mountain gods. It also came to be worshiped as the protector of the world and the god of child-bearing and safe childbirth. Keep God in your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1529_3459d7f33d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

