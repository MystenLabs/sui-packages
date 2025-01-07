module 0xc705635483bdc994b1bfbf14930bdf96759263e76e3d26f1734f8b6b8163a440::suimonkey {
    struct SUIMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONKEY>(arg0, 6, b"SUIMONKEY", b"Sui Monkey", b"First Monkey meme on SUIchain. Lets fucking out jeeters! This go to BlueMove!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eeewewf_b0883b45f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

