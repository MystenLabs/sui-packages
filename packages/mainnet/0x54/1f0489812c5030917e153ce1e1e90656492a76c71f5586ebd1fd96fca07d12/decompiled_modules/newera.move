module 0x541f0489812c5030917e153ce1e1e90656492a76c71f5586ebd1fd96fca07d12::newera {
    struct NEWERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWERA>(arg0, 9, b"NEWERA", b"Newmeme", b"Era is here back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da3fb79a-6437-486f-89af-6332b11904a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

