module 0x364581aaad73e9ff87423b516afefbb8ba28a6353f3358144c760c0292aa6348::smashie {
    struct SMASHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASHIE>(arg0, 6, b"SMASHIE", b"Smashie Sui", b"$SMASHIE is the first pickleball memecoin on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016044_63e2907fce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

