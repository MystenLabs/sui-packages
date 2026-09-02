module 0x92f4be20150dee515acba0c0cab85d22d10f209775f87bff8fda1b1c9666d8e5::ssilver {
    struct SSILVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSILVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12756-xbSLER1XqoAzWtIcHsniUn3FYBpoGl-s92sCxFBpaGlF6Ql9ycmNxWhsS37kj.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12756-xbSLER1XqoAzWtIcHsniUn3FYBpoGl-s92sCxFBpaGlF6Ql9ycmNxWhsS37kj.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SSILVER>(arg0, 9, b"SSILVER", b"SUI SILVER", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSILVER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSILVER>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SSILVER>>(0x2::coin::mint<SSILVER>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

