module 0xa3ab4582004eed74c0dc7f3082406da1e2f75614790074b8393fbb9a6d5b351e::chepw {
    struct CHEPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPW>(arg0, 6, b"Chepw", b"Chad Pepe", b"LAUNCHING TODAY 18:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731387686037.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEPW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

