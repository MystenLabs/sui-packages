module 0xb1005a10b6905f4a9c9bdb1e2a20b9d679e0a55cfeebe14f1682bebe82cfa1f3::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 9, b"BBS", b"Babysex", b"SEXYBABY.DAILY DRAW FOR THE MEETING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2679e4be88b342c7785c3720154268ecblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

