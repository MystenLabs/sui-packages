module 0xa969948a77d71dfce0ad28febe88e42a9808a84dbc8c019395f2be8b3ebc6e71::mudi {
    struct MUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDI>(arg0, 9, b"MUDI", b"Mudi", b"The first Dog memecoin under Sui Ecosystem which is very intelligent and very lively. My Dog lover come support this community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c968364-df18-400b-b418-f0b215ed6eab-IMG_6553.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

