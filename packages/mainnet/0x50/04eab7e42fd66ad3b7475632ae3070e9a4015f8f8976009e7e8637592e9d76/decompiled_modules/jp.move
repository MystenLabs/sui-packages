module 0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp {
    struct JP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JP>(arg0, 0, b"YEN", b"YEN of Japan", b"Japanese money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse4-mm.cn.bing.net/th/id/OIP-C.XVkbV--98d7_YfeLR2a_fAHaHa?rs=1&pid=ImgDetMain")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JP>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JP>>(v1);
    }

    // decompiled from Move bytecode v6
}

