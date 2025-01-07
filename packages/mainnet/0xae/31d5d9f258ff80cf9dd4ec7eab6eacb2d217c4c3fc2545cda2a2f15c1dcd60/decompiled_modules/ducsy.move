module 0xae31d5d9f258ff80cf9dd4ec7eab6eacb2d217c4c3fc2545cda2a2f15c1dcd60::ducsy {
    struct DUCSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCSY>(arg0, 6, b"DUCSY", b"Ducsy", b"$DUCSY The Duck With a Knife  Born to conquer and meme.! This is not just a meme token  its a symbol of rebellion and resilience in the crypto world. Get ready to join the flock and ride the sharpest pump in history. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/346344565_49aedb6468.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

