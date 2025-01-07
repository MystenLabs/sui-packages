module 0xb2622352315a2a8136f81484d832cf4839f7597afc918b1362632ea66d87bb57::ynh {
    struct YNH has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YNH>(arg0, 6, b"YNH", b"Yunoh", b"Ackkkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732198100568.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YNH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YNH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

