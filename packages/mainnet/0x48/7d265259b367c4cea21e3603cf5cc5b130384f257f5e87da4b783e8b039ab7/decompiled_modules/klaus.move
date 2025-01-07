module 0x487d265259b367c4cea21e3603cf5cc5b130384f257f5e87da4b783e8b039ab7::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 6, b"KLAUS", b"KLAUS On Sui", b"$KLAUS - Fish, Big Dream. Riding the wave into the next generation of meme tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_20_09_11_51f342cedf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

