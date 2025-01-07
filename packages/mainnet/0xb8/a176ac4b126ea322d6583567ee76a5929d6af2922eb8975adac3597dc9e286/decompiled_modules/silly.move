module 0xb8a176ac4b126ea322d6583567ee76a5929d6af2922eb8975adac3597dc9e286::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLY>(arg0, 6, b"SILLY", b"Silly Dragon", b"$SILLY  Mascot of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Oip9k_Q5_400x400_00f9358052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

