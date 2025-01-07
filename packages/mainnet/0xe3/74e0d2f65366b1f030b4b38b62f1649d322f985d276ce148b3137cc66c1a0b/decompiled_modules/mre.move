module 0xe374e0d2f65366b1f030b4b38b62f1649d322f985d276ce148b3137cc66c1a0b::mre {
    struct MRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRE>(arg0, 9, b"MRE", b"Moore", b"This token will be one of its kind, and will explore the world of meme coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/791498c8-8297-4e5f-af81-6d962ecb6db1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

