module 0x6c1f2fbc29010f4203e07deba7c74c15b84f6c0a5e014c7f6f148db1382328d::fck727a {
    struct FCK727A has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCK727A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCK727A>(arg0, 6, b"Fck727a", b"Fck 727a", b"Fck the Notorious Fudder in Sui Network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736644710002.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCK727A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCK727A>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

