module 0xf3253cd23a39adfddff7659d72962adb168e53bf546455900648a686e6e306fc::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"HAMMY", b"Sad Hamster on Sui", b"Legendary meme Sad Hamster on SUI. Hammy to the moon, did you buy this?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/photo_2024_09_24_23_42_11_835350eb0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

