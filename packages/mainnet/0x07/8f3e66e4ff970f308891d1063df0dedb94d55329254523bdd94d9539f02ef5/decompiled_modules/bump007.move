module 0x78f3e66e4ff970f308891d1063df0dedb94d55329254523bdd94d9539f02ef5::bump007 {
    struct BUMP007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMP007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMP007>(arg0, 9, b"BUMP007", b"BUMBLE", b"Silly grumpy lazy meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efc4db93-4fac-4607-b539-193658b08baa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMP007>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUMP007>>(v1);
    }

    // decompiled from Move bytecode v6
}

