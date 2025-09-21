module 0x71ee71dbf4d093fe47cab372fe5dd51f930a8676ffe29f90ae93d099cc7a5e11::chinese {
    struct CHINESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINESE>(arg0, 0, b"CHINESE", b"CHINESE", b"CHINESE EAT SNAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://meme.rolipoli.xyz/meme-icons/1758485717981_1b04d734-3ef8-4055-ae96-d6c5729514ef.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CHINESE>>(0x2::coin::mint<CHINESE>(&mut v2, 99, arg1), @0x6dc40a6b35310e5dd5cb7767f8d8477b9c1fc219f0cc511f45928eddaae341dd);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CHINESE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

