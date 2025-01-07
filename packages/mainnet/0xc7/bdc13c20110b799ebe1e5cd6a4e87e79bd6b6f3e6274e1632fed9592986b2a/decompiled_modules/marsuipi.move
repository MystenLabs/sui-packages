module 0xc7bdc13c20110b799ebe1e5cd6a4e87e79bd6b6f3e6274e1632fed9592986b2a::marsuipi {
    struct MARSUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSUIPI>(arg0, 6, b"MARSUIPI", b"Marsuipilami", b" Marsuipilami Coin: Inspired by the iconic cartoon! Swinging through the crypto jungle with wild energy and nostalgic vibes. Ready to leap to the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marsupilami_a97fcc48c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARSUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

