module 0xa6050898f2ba405ae5429e0971de7b73defcfbf8dafb4d8048629c167058c19b::jks {
    struct JKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKS>(arg0, 6, b"JKS", b"Jakesui", b"jake paul the problem child", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdeb4645b3414aa19de8a50b0e880421_fe170efe3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

