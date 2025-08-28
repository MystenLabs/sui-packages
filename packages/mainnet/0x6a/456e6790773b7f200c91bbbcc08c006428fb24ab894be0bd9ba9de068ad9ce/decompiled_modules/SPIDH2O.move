module 0x6a456e6790773b7f200c91bbbcc08c006428fb24ab894be0bd9ba9de068ad9ce::SPIDH2O {
    struct SPIDH2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDH2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIDH2O>(arg0, 6, b"Spider Water", b"SPIDH2O", b"A meme coin for the arachnid hydrators! Dive into the web of liquidity with Spider Water, where every drop counts and every spin creates waves. Whether you're a fan of eight-legged friends or just love a refreshing sip of meme magic, SPIDH2O is your ticket to the decentralized pond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreih3pxnq4tbrtqxhocpdk36ea3urd2cckdkht4xp64ag6pzmocivbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIDH2O>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIDH2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

