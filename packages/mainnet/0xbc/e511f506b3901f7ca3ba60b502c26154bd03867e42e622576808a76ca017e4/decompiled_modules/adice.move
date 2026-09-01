module 0xbce511f506b3901f7ca3ba60b502c26154bd03867e42e622576808a76ca017e4::adice {
    struct ADICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/0d097249-85cd-4932-92ed-8dee9b3c963d-JimnUrtihyenvjKJAtYAqWBEfNTeSF.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/0d097249-85cd-4932-92ed-8dee9b3c963d-JimnUrtihyenvjKJAtYAqWBEfNTeSF.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<ADICE>(arg0, 9, b"ADICE", b"AIDAVICE", b"AIDA ON VICE", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADICE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADICE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ADICE>>(0x2::coin::mint<ADICE>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

