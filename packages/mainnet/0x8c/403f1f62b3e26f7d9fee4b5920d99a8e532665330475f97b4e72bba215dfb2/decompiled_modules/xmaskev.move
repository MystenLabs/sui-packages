module 0x8c403f1f62b3e26f7d9fee4b5920d99a8e532665330475f97b4e72bba215dfb2::xmaskev {
    struct XMASKEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMASKEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMASKEV>(arg0, 6, b"XMASKEV", b"Aqua Bandits", b"Use the power of the H20 chain to send the Aqua Bandits to the bonding curve!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6103_279b0e334f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMASKEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMASKEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

