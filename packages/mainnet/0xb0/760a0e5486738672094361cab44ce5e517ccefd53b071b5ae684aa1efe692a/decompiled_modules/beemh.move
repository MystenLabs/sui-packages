module 0xb0760a0e5486738672094361cab44ce5e517ccefd53b071b5ae684aa1efe692a::beemh {
    struct BEEMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEMH>(arg0, 9, b"BEEmH", b"BEEmyHoney", b"ssadada", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0135885b18b2e913110486241f3ea126blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEEMH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEMH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

