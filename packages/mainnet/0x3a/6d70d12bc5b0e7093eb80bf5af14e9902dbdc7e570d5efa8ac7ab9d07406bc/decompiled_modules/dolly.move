module 0x3a6d70d12bc5b0e7093eb80bf5af14e9902dbdc7e570d5efa8ac7ab9d07406bc::dolly {
    struct DOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLY>(arg0, 6, b"DOLLY", b"DOLLY FAN ON SUI", b"$DOLLY FAN The cutest dog in SUI, also a friend of Moodengs. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dolly_0d6f7a8f0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

