module 0xbe296cc6ed0b2963241fb4dce4bcbbfb19421e2846051cb228eab4934302eda5::azol {
    struct AZOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZOL>(arg0, 6, b"AZOL", b"Azol-infinitie", b"Azol-Infinitie is a cutting-edge cryptocurrency token designed to embody limitless possibilities. Built on the Sui blockchain, it delivers fast, scalable transactions with a focus on innovation, community, and growth. Azol-Infinitie is your gateway to a decentralized future without boundaries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/122d8385_5478_4446_9ed1_a7d5b274d82e_caaf9f756a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

