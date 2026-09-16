module 0xbfac2cf3367487170cd56ea71f284a1064195a17640ab7c59e07c34f6c529a94::trencher {
    struct TRENCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Gemini_Generated_Image_fdu4nifdu4nifdu4-3O6qPscwaTVspLQtxhIDyk7GT2OZQL.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Gemini_Generated_Image_fdu4nifdu4nifdu4-3O6qPscwaTVspLQtxhIDyk7GT2OZQL.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<TRENCHER>(arg0, 9, b"TRENCHER", b"ADENIYI THE TRENCHER", x"4164656e6979692068617320656e746572656420746865207472656e636865732e2020204e6f772077652061726520616c6c20245452454e4348455227730a0a582068747470733a2f2f782e636f6d2f6e6979697468657472656e63686572", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRENCHER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHER>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TRENCHER>>(0x2::coin::mint<TRENCHER>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

