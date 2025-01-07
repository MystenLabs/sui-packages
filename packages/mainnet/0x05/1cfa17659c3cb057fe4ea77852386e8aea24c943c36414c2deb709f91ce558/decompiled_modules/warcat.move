module 0x51cfa17659c3cb057fe4ea77852386e8aea24c943c36414c2deb709f91ce558::warcat {
    struct WARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCAT>(arg0, 9, b"WARCAT", b"WOW", b"From another univers to another univers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee28efb2-d52e-454f-9ebc-b237a985a1da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

