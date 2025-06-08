module 0xed67ae6b4a4529c87e7af18fb7d6277bf228869288b6276da789778b2e9f02b3::sums {
    struct SUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMS>(arg0, 6, b"SUMS", b"sumspay", b"You Can Easily Exchange Your Bitcoin & Giftcards with us on Sumspay Website", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigrakwvbq46qvplbltmmm33y7ye4qk2vo4y5ovj4ltvw2vgjhfpgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

