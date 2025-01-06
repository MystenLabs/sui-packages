module 0xe44f7eba9848bb254a7c11be3a8ff6f9a03f30ee8de89bfce73373680068ceea::booboo {
    struct BOOBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBOO>(arg0, 6, b"BOOBOO", b"Boo-Boo Tummy", b"We have to make the boo-boo tummy go away by launching it to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Vet6_Ta_400x400_cef3aba8ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

