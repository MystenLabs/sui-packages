module 0x8014d91302a6b0f580aec0adfd45f586506c56a20a18cbfb678baae4de362f11::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/photo_2026-09-27_05-59-25-vCAbio3n6oIAVlAoOAyn9ldi0BPIpS.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/photo_2026-09-27_05-59-25-vCAbio3n6oIAVlAoOAyn9ldi0BPIpS.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SB>(arg0, 9, b"SB", b"SuiBender", b"even the avatar knows sui", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SB>>(0x2::coin::mint<SB>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

