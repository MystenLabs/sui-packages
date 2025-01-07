module 0xac027c678fa7419e5ca5cdd00371addfa5850646788ae19a759d7ca6e9bd944::wecat {
    struct WECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECAT>(arg0, 9, b"WECAT", b"COBRA", b"Bull Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46a5e9b1-7f96-4b4e-885a-e3fd917004dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

