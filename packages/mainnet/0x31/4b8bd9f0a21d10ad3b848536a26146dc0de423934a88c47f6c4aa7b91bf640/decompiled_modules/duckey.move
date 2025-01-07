module 0x314b8bd9f0a21d10ad3b848536a26146dc0de423934a88c47f6c4aa7b91bf640::duckey {
    struct DUCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKEY>(arg0, 6, b"DUCKEY", b"Sui Duckey", b"Meet Sui $DUCKEY. He is more than just a cute figure; he's a mix of whimsy and deep introspection. With Furies signature touch, Ducky brings out a world where innocence meets complexity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_K_Wct7_J_400x400_47afbf514c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

