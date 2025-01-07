module 0xb4c4d57142e04793cddc42d6eb19acbb965385380d3f4742a7bd98cb9d4479f2::chama {
    struct CHAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMA>(arg0, 6, b"CHAMA", b"alex pereira", b"chama defeats Khalil Rountree Jr. by TKO to defend his light heavyweight title for THIRD time in 2024!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffff_8b2dc1f8e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

