module 0x335dc875ee40d25e0813c077738fdf15f18d3a47de548d4a316a14b250c7eaed::puddlepop {
    struct PUDDLEPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDLEPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDLEPOP>(arg0, 9, b"PUDDY", b"Puddlepop", b"Every dip is a splash! Puddlepop jumps in feet-first, makes a mess, and somehow finds treasure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibemv2m4tvbtpciltovobmfyixqoj2dirj6rrgvqhikooj73sizuq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUDDLEPOP>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDLEPOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDDLEPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

