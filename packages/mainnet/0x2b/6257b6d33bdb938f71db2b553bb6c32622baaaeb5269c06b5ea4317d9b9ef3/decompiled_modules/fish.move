module 0x2b6257b6d33bdb938f71db2b553bb6c32622baaaeb5269c06b5ea4317d9b9ef3::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"DragonFish", b"Distribution based on fair launch inscriptions, Object ID = 0x90d929beb4075b54e5651dcf7115213008c82c7229b343bc8f87a4553a8a2f8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zu36u52z6ddktcq6agwvv4tkfmi24c7noopwh6qu7tssxklm2nqa.arweave.net/zTfqd1nwxqmKHgGtWvJqKxGuC-1zn2P6FPzlK6ls02A?ext=jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISH>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

