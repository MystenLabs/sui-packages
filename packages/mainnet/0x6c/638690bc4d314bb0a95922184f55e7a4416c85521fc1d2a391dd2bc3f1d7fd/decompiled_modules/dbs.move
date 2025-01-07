module 0x6c638690bc4d314bb0a95922184f55e7a4416c85521fc1d2a391dd2bc3f1d7fd::dbs {
    struct DBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBS>(arg0, 9, b"DBS", b"Digger Bos", b"Digger Bos is test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbe25c1d-8ec6-4d78-9dc5-d7ebc7e9c46f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

