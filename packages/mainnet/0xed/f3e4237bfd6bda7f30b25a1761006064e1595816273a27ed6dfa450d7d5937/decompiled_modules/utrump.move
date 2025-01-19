module 0xedf3e4237bfd6bda7f30b25a1761006064e1595816273a27ed6dfa450d7d5937::utrump {
    struct UTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTRUMP>(arg0, 6, b"UTRUMP", b"Unofficialy Trump", b"The only Unofficial trump meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026993_1083cb2900.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

