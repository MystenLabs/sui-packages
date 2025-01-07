module 0x21226ca23cf50dbd9edb83e914b79fd79ab85ab91239066a6e33ba8edacf3306::mbga {
    struct MBGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBGA>(arg0, 6, b"MBGA", b"$MBGA", b"Let's Make Bitcoin Great Again Together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Njr_QP_59_400x400_4d06f3ce5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

