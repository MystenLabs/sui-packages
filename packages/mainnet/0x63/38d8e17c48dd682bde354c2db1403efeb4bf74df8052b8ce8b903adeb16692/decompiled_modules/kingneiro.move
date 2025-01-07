module 0x6338d8e17c48dd682bde354c2db1403efeb4bf74df8052b8ce8b903adeb16692::kingneiro {
    struct KINGNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGNEIRO>(arg0, 6, b"Kingneiro", b"kingneiro", x"546865206e6578742062696720446f6765206f6e207375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731082850428.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGNEIRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGNEIRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

