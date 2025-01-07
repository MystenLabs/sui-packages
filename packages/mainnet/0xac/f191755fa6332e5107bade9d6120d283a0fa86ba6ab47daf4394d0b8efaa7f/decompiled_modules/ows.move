module 0xacf191755fa6332e5107bade9d6120d283a0fa86ba6ab47daf4394d0b8efaa7f::ows {
    struct OWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWS>(arg0, 6, b"OWS", b"Owl on Sui", b"\"Welcome to the Owl family!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_111418_344_982217eff8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

