module 0xc785c3905e7d38d95c1ebb33cdc218e6cc33c31e6043c3b3d7891e873beb76c2::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 9, b"PUSSY", b"Pussy.", b"her pussy, hot, moist and wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4aaeba4-794b-4929-869c-8d616976cf99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

