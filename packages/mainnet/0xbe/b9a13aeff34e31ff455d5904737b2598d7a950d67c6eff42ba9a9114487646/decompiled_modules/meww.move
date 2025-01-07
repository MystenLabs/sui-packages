module 0xbeb9a13aeff34e31ff455d5904737b2598d7a950d67c6eff42ba9a9114487646::meww {
    struct MEWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWW>(arg0, 9, b"MEWW", b"MEWWW", b"EMEMEEMEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/430df04420b06a141ccad0ad77cb3c35blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

