module 0xa0b937f9f6c7cd7e865b3c5bde42dc21dee8e847a7226e6de3aa9af4f64059b4::ncat {
    struct NCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ERA2E-cM7NNZwyxtQUEylQ51Wu29tTh1y246.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/ERA2E-cM7NNZwyxtQUEylQ51Wu29tTh1y246.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<NCAT>(arg0, 9, b"NCAT", b"Nvidia Cat", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<NCAT>>(0x2::coin::mint<NCAT>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

