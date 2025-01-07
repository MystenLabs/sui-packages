module 0x7f9b453288c1e1e759641125f3bd2067ce6b999fce4d8e701c6b5c4b521d4b6c::wzrd {
    struct WZRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZRD>(arg0, 9, b"WZRD", b"WIZZAED", b"spell this coin!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2380b559-f7be-4a17-940a-4af8667bbc6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

