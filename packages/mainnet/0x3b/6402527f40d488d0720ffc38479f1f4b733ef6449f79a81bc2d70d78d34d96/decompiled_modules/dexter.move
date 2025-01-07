module 0x3b6402527f40d488d0720ffc38479f1f4b733ef6449f79a81bc2d70d78d34d96::dexter {
    struct DEXTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEXTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEXTER>(arg0, 9, b"DEXTER", b"Waweee", b"Dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed8adac6-f1c5-4662-9b32-4d695543023a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEXTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

