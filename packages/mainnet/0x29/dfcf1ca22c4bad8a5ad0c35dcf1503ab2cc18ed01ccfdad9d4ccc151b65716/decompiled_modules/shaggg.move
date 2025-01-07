module 0x29dfcf1ca22c4bad8a5ad0c35dcf1503ab2cc18ed01ccfdad9d4ccc151b65716::shaggg {
    struct SHAGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAGGG>(arg0, 9, b"SHAGGG", b"Shaggy", b"Welcome to the mysterious Scooby dooby doooooooooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46ed9a17-dbce-4cfa-827a-037cce08139e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

