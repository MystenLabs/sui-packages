module 0xe9c36752187694992e5da516b3398026e2d79e47611ee0ac55dc41629b4dee34::ht123 {
    struct HT123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HT123>(arg0, 9, b"HT123", b"HTest123", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e77b85e7edd3224eeb7e2d19231b1018blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HT123>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT123>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

