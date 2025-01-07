module 0x7db05afeb1a97c0f58a47f70489adc8bf8eee4a558db7e1105917e274569e90b::surx {
    struct SURX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURX>(arg0, 6, b"SURX", b"suirex", x"536f6d657468696e672062696720616e6420626c756520697320636f6d696e6720206578636c75736976656c7920746f200a40686f7061676772656761746f720a206f6e204f63746f6265722031322e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_393141540e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURX>>(v1);
    }

    // decompiled from Move bytecode v6
}

