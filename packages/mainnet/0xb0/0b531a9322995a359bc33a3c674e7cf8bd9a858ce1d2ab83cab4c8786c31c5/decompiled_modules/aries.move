module 0xb00b531a9322995a359bc33a3c674e7cf8bd9a858ce1d2ab83cab4c8786c31c5::aries {
    struct ARIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIES>(arg0, 6, b"ARIES", b"ARIES AI", b"Aries Build On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029164_058b5a3604.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

