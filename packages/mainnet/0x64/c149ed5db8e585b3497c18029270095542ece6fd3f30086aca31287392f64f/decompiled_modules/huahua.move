module 0x64c149ed5db8e585b3497c18029270095542ece6fd3f30086aca31287392f64f::huahua {
    struct HUAHUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUAHUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUAHUA>(arg0, 6, b"HuaHua", b"huahuapangda", b"This is a very famous panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/88888888_9f93b34dd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUAHUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUAHUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

