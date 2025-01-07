module 0x404fa4819a007b63cb45a112c585c6f8463985cd917aae321f0025bafcb5bdd0::bark {
    struct BARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARK>(arg0, 6, b"BARK", b"BarkSui", x"4a7573742061206375746520646f67206261726b696e206f6e2024535549202d0a244241524b204261726b5355492062697463682121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047920_9fecf61dc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

