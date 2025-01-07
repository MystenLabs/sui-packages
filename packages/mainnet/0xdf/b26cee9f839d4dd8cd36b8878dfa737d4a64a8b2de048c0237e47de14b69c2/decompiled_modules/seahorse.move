module 0xdfb26cee9f839d4dd8cd36b8878dfa737d4a64a8b2de048c0237e47de14b69c2::seahorse {
    struct SEAHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAHORSE>(arg0, 9, b"SEAHORSE", b"Sea Horse Coin", b"Swa horse is meme on sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844479048766062592/9bUMenX2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEAHORSE>(&mut v2, 640000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAHORSE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

