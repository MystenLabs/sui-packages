module 0x3e99b477e9442e194918b9623f4bc6b3dc549cc08e4211ce6a837b203f4a774c::vicedog {
    struct VICEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/meme_1-ZR0ZhZv6DzUt15JlucLfXvq6INHeMP.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/meme_1-ZR0ZhZv6DzUt15JlucLfXvq6INHeMP.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<VICEDOG>(arg0, 9, b"VICEDOG", b"Dog from VICE", b"SUI dog that got nowhere else to run. VICE DOG", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICEDOG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICEDOG>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VICEDOG>>(0x2::coin::mint<VICEDOG>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

