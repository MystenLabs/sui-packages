module 0x8f6f7a12ef59f00b393201a2a8405b1b1439bde015118ff9109cb2058efa2eba::htwoo {
    struct HTWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTWOO>(arg0, 6, b"Htwoo", b"Suihtwoo", b"Htwoo on duo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9433_f1c334fce2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

