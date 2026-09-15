module 0x4f72444e4ed1c53ac68bb864dbb964823b1761d476a2224e74a5954a3cdd20b1::sui500 {
    struct SUI500 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI500, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000053177-HXOdX0AEMoiWR1HVGDDifxbmo2JgUM.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000053177-HXOdX0AEMoiWR1HVGDDifxbmo2JgUM.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SUI500>(arg0, 9, b"SUI500", x"535549353030e2808b", b"The first S&P 500 on Sui.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI500>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI500>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI500>>(0x2::coin::mint<SUI500>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

