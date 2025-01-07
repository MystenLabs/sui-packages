module 0x3219b20fa57526cbfe761ca1eb3a7fd387710ef2e0ff03d31921ad5444202410::mudi {
    struct MUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDI>(arg0, 9, b"MUDI", b"Mudi", b"The first Dog memecoin under Sui Ecosystem which is very intelligent and very lively. My Dog lover come support this community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88831c71-79ba-4c2b-b608-68981af337da-IMG_6553.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

