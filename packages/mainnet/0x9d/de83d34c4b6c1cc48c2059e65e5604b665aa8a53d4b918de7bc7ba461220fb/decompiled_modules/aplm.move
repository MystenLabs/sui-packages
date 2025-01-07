module 0x9dde83d34c4b6c1cc48c2059e65e5604b665aa8a53d4b918de7bc7ba461220fb::aplm {
    struct APLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: APLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APLM>(arg0, 9, b"APLM", b"Apolomax", b"token distribution ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a436abb-b69f-4598-8f6b-787effaab4da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

