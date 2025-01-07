module 0xc2acb62fc5fce8aaf736e595fe9e066d1813c318aa8eded266030094cdeb4447::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 9, b"HOLD", b"HOLD IT", b"Hold it and it will go up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Kp34zAJ.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOLD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

