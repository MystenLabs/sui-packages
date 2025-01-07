module 0x307d29e5f1a8f9e821e7a09a26e56a5eb7cdef0b1fdc494faa07cac953a5efbc::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 9, b"MIHARU", b"Smiling Dolphin", b"he Smiling Dolphin meme is based on a photo of the Finless Porpoise named Miharu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x5981e98440e41fa993b26912b080922b8ed023c3.png?size=lg&key=105a05")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIHARU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

