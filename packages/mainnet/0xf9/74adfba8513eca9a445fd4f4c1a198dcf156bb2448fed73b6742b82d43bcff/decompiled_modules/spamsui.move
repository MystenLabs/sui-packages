module 0xf974adfba8513eca9a445fd4f4c1a198dcf156bb2448fed73b6742b82d43bcff::spamsui {
    struct SPAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAMSUI>(arg0, 6, b"SPAMSUI", b"Spam to Earn", b"\"Spam to Earn\" a.k.a. \"Proof of Spam\" on Sui. Welcome to the community-owned page of $SPAM! TG: https://t.me/spam_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_08_14_30_38_d0dc47f711.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

