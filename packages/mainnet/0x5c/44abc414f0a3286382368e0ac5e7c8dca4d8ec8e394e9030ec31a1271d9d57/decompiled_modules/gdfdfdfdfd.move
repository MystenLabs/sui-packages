module 0x5c44abc414f0a3286382368e0ac5e7c8dca4d8ec8e394e9030ec31a1271d9d57::gdfdfdfdfd {
    struct GDFDFDFDFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDFDFDFDFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDFDFDFDFD>(arg0, 9, b"GDFDFDFDFD", b"tfgfhfthfh", b"fdgfgfgfgfgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcadcadb-e6a7-4193-b8f7-ba1f2b75c146.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDFDFDFDFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDFDFDFDFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

