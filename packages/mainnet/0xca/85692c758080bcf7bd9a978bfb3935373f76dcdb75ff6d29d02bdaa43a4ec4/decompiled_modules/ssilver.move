module 0xca85692c758080bcf7bd9a978bfb3935373f76dcdb75ff6d29d02bdaa43a4ec4::ssilver {
    struct SSILVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSILVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12756-xbSLER1XqoAzWtIcHsniUn3FYBpoGl.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/12756-xbSLER1XqoAzWtIcHsniUn3FYBpoGl.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SSILVER>(arg0, 9, b"SSILVER", b"Sui Silver", x"5375692053696c766572e2808b", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSILVER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSILVER>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SSILVER>>(0x2::coin::mint<SSILVER>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

