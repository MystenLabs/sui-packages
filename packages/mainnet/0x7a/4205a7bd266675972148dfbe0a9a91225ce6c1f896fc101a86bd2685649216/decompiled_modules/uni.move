module 0x7a4205a7bd266675972148dfbe0a9a91225ce6c1f896fc101a86bd2685649216::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/QQ20260820-231944-jfwzZqeuLBes5r49JJJz8m9fSsBsyi.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/QQ20260820-231944-jfwzZqeuLBes5r49JJJz8m9fSsBsyi.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<UNI>(arg0, 9, b"UNI", b"Uni", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<UNI>>(0x2::coin::mint<UNI>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

