module 0x72ef59cd7ae6fdc164bc6cd09a178c6e20fd484b32f3e11cef67099f2f40cffb::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 6, b"SPAM", b"Spam On Sui", b"Spam to Earn\" a.k.a. \"Proof of Spam\" on Sui. Welcome to the community-owned page of $SPAM! TG: https://t.me/spam_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spam_10ebc7e7e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

