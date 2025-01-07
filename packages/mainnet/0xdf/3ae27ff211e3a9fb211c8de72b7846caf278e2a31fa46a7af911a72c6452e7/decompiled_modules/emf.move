module 0xdf3ae27ff211e3a9fb211c8de72b7846caf278e2a31fa46a7af911a72c6452e7::emf {
    struct EMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMF>(arg0, 6, b"Emf", b"Emoji fan ", b"Token meme fan emoji ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732543207665.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

