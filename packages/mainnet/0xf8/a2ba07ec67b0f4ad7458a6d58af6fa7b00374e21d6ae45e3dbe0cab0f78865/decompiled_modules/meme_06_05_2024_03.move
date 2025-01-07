module 0xf8a2ba07ec67b0f4ad7458a6d58af6fa7b00374e21d6ae45e3dbe0cab0f78865::meme_06_05_2024_03 {
    struct MEME_06_05_2024_03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_06_05_2024_03, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_06_05_2024_03>(arg0, 6, b"MEME_06_05_2024_03", b"meme0605202403", b"06 May 2024 second", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_06_05_2024_03>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_06_05_2024_03>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_06_05_2024_03>>(v1);
    }

    // decompiled from Move bytecode v6
}

