module 0xa185577a314029336231d33b9c35d022a26f9180e290f58227b1cfc87a9ce2a9::doogi {
    struct DOOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOGI>(arg0, 9, b"DOOGI", b"DOGGIMOON", b"for community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e67c3fc-67a3-468c-8c81-d27a7f789ab9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

