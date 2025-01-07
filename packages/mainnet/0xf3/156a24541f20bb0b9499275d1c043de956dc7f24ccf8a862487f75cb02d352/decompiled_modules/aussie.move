module 0xf3156a24541f20bb0b9499275d1c043de956dc7f24ccf8a862487f75cb02d352::aussie {
    struct AUSSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUSSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUSSIE>(arg0, 9, b"Aussie", b"Aussie", b"The most clever meme dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AUSSIE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUSSIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUSSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

