module 0xd324b9a5cebb9db5609b77ad3ed96a91d42241e9e10be58e11f590d0786ef490::sucks {
    struct SUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCKS>(arg0, 6, b"SUCKS", b"Duck on Sui", b"The legendary Walking Ducks, just arrived on Sui to be a legendary memecoin we called $SUCKS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_12_30_01_36_42_ASDASD_e1437079a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

