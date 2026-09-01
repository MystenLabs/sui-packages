module 0x7443ff78503820fecf7e75d3169f8f90e8e74804889abdf8599f75946854eb7b::bbull {
    struct BBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/photo_2026-07-05_11-47-28-MoGEEmTS7I8aHUQJLTrA5q4GXhXKNB.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/photo_2026-07-05_11-47-28-MoGEEmTS7I8aHUQJLTrA5q4GXhXKNB.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<BBULL>(arg0, 9, b"BBULL", b"Bald Bull", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBULL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBULL>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BBULL>>(0x2::coin::mint<BBULL>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

