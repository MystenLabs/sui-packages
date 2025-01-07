module 0x2424a316447db96edd61614a640fc44e5c45833b703e1f59a91051473b3dc831::murod {
    struct MUROD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUROD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUROD>(arg0, 9, b"MUROD", b"Murod cto", b"Murod cto to billioner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d374ac8e-f5e5-4774-b59d-d23b5b67107f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUROD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUROD>>(v1);
    }

    // decompiled from Move bytecode v6
}

