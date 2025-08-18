module 0x7ee780be4427441a5c0beeb0276c53b59c6e957081dc6fadac3d865ad1e7e649::xiao {
    struct XIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAO>(arg0, 9, b"XIAO", b"My XIAO Token", b"My XIAO Token for Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/3377082/Fuzzing-Dicts/master/Somd5%20Dictionary/SONG.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XIAO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

