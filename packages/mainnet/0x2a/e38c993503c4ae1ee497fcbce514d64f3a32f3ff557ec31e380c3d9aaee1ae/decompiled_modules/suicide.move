module 0x2ae38c993503c4ae1ee497fcbce514d64f3a32f3ff557ec31e380c3d9aaee1ae::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"SUIcide", b"introducing SUICIDE, the boldest memecoin on the Sui network! With lightning-fast transactions and killer gains, this edgy token can make you happy again and stop to think suicidade. Join the madness and ride to the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_09_13_31_41_e1332f6ded.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

