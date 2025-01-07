module 0x3d361945a1734010f7f01e231363d46ee1280090faea08751c5186d8c5902793::mlknk {
    struct MLKNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLKNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLKNK>(arg0, 6, b"MLKNK", b"MalkaNeko", b"Collivan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_23_18_35_39_bad315fcab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLKNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLKNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

