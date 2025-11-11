module 0x7b0075309f3faf6caa38a9fffd896673d93fcddad8d0513ce185e2d8eaf14e71::utato {
    struct UTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTATO>(arg0, 9, b"uTATO", b"uTATO", b"Used to unlock the TATO airdrop early", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/tato/uTATO.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UTATO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTATO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<UTATO>>(0x2::coin::mint<UTATO>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

