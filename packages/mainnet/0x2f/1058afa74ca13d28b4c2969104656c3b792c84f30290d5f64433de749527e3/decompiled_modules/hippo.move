module 0x2f1058afa74ca13d28b4c2969104656c3b792c84f30290d5f64433de749527e3::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/qfODMEau_400x400-iwnkKAwB6Y4CQMIejW2RrMpTfmvB56.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/qfODMEau_400x400-iwnkKAwB6Y4CQMIejW2RrMpTfmvB56.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<HIPPO>(arg0, 9, b"HIPPO", b"sudeng", x"6a757374206120486970706f2072756c696e6720746865205375692077617465727320f09fa69bf09f92a7", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPPO>>(0x2::coin::mint<HIPPO>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

