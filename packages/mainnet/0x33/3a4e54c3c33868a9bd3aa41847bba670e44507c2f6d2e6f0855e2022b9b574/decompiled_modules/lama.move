module 0x333a4e54c3c33868a9bd3aa41847bba670e44507c2f6d2e6f0855e2022b9b574::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"Lama", b"LAMA ON SUI", b"Lama is a memecoin on the Sui blockchain launched through MovePump, bringing excitement and viral potential to the crypto community. With low transaction fees and an enthusiastic community, Lama combines humor and opportunity in one token ready to \"to the moon.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241101_200751_de5e95eab3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

