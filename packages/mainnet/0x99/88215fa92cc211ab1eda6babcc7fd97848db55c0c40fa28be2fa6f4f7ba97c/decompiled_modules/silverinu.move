module 0x9988215fa92cc211ab1eda6babcc7fd97848db55c0c40fa28be2fa6f4f7ba97c::silverinu {
    struct SILVERINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILVERINU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Screenshot_2026-09-02_at_00.12.48-oBFURuIDvBM4F6PxN0UGaOU7Atk04F.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Screenshot_2026-09-02_at_00.12.48-oBFURuIDvBM4F6PxN0UGaOU7Atk04F.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SILVERINU>(arg0, 9, b"SILVER INU", b"Silver Inu", b"silver inu", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILVERINU>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILVERINU>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SILVERINU>>(0x2::coin::mint<SILVERINU>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

