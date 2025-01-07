module 0xbdeda5e24040eed830c9e2bc6f25aea27a9bccde0cf8f6f73ba94ac17d0dc376::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"Bob the blob", b"Download the SUI wallet for the SUI blockchain. Then, purchase SUI using your debit card with Moonpay OR swap existing coins for $SUI. After, visit any SUI based DEX and trade your $SUI for $BOB.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9v4_N_j4w_400x400_a07466b5ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

