module 0x4a0c7df9cfe8166b53435f178d637f3b348094a1daebdfbd8f76f88c1e2be942::meme_02_05_2024 {
    struct MEME_02_05_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_02_05_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_02_05_2024>(arg0, 6, b"MEME_02_05_2024", b"meme02052024", b"02 May 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_02_05_2024>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_02_05_2024>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_02_05_2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

