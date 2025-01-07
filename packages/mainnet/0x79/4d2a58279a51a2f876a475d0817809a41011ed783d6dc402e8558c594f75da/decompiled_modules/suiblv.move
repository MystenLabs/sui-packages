module 0x794d2a58279a51a2f876a475d0817809a41011ed783d6dc402e8558c594f75da::suiblv {
    struct SUIBLV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLV>(arg0, 6, b"SUIBLV", b"SUILIEVE", b"Believe in something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_29_8_14_14_PM_129c87688b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLV>>(v1);
    }

    // decompiled from Move bytecode v6
}

