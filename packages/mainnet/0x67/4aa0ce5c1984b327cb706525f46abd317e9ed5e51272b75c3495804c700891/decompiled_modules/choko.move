module 0x674aa0ce5c1984b327cb706525f46abd317e9ed5e51272b75c3495804c700891::choko {
    struct CHOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOKO>(arg0, 6, b"CHOKO", b"CHOKO and KNIGHT", b"Happiest cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5704_2e560475b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

