module 0x8da8a688d14295681d0bf4156a56abe677ef997771fb810c976e3514df93cabf::kwmdb {
    struct KWMDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWMDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWMDB>(arg0, 9, b"KWMDB", b"hejen", b"gduei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7ab098f-5e97-4dfd-afe2-d185fa0b1179.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWMDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWMDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

