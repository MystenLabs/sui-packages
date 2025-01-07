module 0x3f5b5bc44ef7039acc1900097f70fd521eabeaeb3b9e8dab1cf9951904611b99::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"BIAOQING PANDA", b"THE MOST FAMOUS CHINESE MEME NOW COMMING SUI, MEET BIAOQING PANDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xr_II_Oirk_400x400_08ccf1ad85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

