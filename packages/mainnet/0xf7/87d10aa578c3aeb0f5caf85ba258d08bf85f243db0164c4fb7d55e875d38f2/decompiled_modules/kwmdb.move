module 0xf787d10aa578c3aeb0f5caf85ba258d08bf85f243db0164c4fb7d55e875d38f2::kwmdb {
    struct KWMDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWMDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWMDB>(arg0, 9, b"KWMDB", b"hejen", b"gduei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20f016b9-8e25-4b37-9665-18b7e8f6bc2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWMDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWMDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

