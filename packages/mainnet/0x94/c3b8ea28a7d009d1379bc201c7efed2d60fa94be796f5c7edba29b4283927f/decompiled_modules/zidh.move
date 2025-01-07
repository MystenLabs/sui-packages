module 0x94c3b8ea28a7d009d1379bc201c7efed2d60fa94be796f5c7edba29b4283927f::zidh {
    struct ZIDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIDH>(arg0, 9, b"ZIDH", b"ndndn", b"hejd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66efa65b-b924-4a01-8279-48514254edbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

