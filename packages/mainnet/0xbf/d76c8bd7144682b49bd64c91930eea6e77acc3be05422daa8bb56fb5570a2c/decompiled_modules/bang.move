module 0xbfd76c8bd7144682b49bd64c91930eea6e77acc3be05422daa8bb56fb5570a2c::bang {
    struct BANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Gemini_Generated_Image_j53oxxj53oxxj53o-JcTrKp8cFa4fvg1PyUkkVRy7xe6j4w.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Gemini_Generated_Image_j53oxxj53oxxj53o-JcTrKp8cFa4fvg1PyUkkVRy7xe6j4w.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<BANG>(arg0, 9, b"BANG", b"born as natural gangsta", b"From Zero to Hero and to the Moon", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANG>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BANG>>(0x2::coin::mint<BANG>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

