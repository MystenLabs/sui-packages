module 0x1ded5e74fb46f182ea47cbf26fddfcf1b8950b1c2feb51ae095b388f40140eec::dape {
    struct DAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAPE>(arg0, 6, b"DAPE", b"Duck Tape", b"Life got you tied up? No worries, DAPE is tied up tooyet it's still winning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052577_d2fd7e7829.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

