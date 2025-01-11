module 0x17d208bcacfe5e79aa694aae8245b99cea3873dd7d98199501d4e8d1dcfa2b0e::timon {
    struct TIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMON>(arg0, 6, b"Timon", b"Timon sui", b"Timon is a developer on a very advanced sui ecosystem, we are about to embark on an important milestone for sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058366_00a6dd1bd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

