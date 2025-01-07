module 0x6156e44e026e057a31ec81398ef1cfc7d024c0d2d427bf285e5fc3da5ccade8d::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 6, b"APT", b"$APT", b"FOR APT SONG FANS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732356012351.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

