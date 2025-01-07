module 0x1733500c972859daee6a2ae45b4befbbb891986263677f0597996750e5b8c59d::quants {
    struct QUANTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTS>(arg0, 6, b"QUANTS", b"QUANT SMOKE", x"546865206f6e657320616c7265616479207265746972653f0a546865206f6e657320736f6f6e20746f207265746972653f0a546865206f6e65732077686f2068617665206465636164657320746f207265746972653f0a416c6c207468652061626f76653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc3qai0_W0_AA_8_SVC_784e15ff66.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

