module 0xe4c97446b0d7814d00474f5233e7740d0b9f112ae5e9e26a8cc221bef76abcc::vice {
    struct VICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/vice-mark-NB4qiuTTy1ihUqL6TvWiifLeFiUIvH.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/vice-mark-NB4qiuTTy1ihUqL6TvWiifLeFiUIvH.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<VICE>(arg0, 9, b"VICE", b"ViceFun", b"VICE FUN", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VICE>>(0x2::coin::mint<VICE>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

