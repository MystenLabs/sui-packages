module 0xb461467394a57e2608e84889c8b0143d3e5a80a94d03d086ad0303ff8505eb4c::meme_06_05_2024_04 {
    struct MEME_06_05_2024_04 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_06_05_2024_04, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_06_05_2024_04>(arg0, 6, b"MEME_06_05_2024_04", b"meme0605202404", b"06 May 2024 second", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_06_05_2024_04>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_06_05_2024_04>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_06_05_2024_04>>(v1);
    }

    // decompiled from Move bytecode v6
}

