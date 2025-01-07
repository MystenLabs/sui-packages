module 0x1ad260e195e1e0579d2a74c4443e04cb8dfbe439ed912d0799050eac27c9bcf3::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 9, b"OWL", b"Owl meme", b"Owl meme so wonderfull, to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29afffee-7776-451f-a91e-58d80830b3e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

