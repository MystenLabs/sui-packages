module 0x8d0a584c7c5b1d0c14dc00c60fbff6b959032a49687c17a0e7aa9d9c708de337::mt {
    struct MT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MT>(arg0, 6, b"MT", b"truonganriu", b"tests", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1764232500595.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

