module 0xae469752ca5be2628a11ed28933d7161d6ad0dd8a458f6d4502e9e6811b4e8c3::suigma {
    struct SUIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA>(arg0, 6, b"SUIGMA", b"SuigmaFace", x"5468697320746f6b656e2069732064656469636174656420746f20616c6c20746865205369676d612043686164732e200a0a4c6574732073656e64207468697320616e642062652061207265616c20537569676d6121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_5884_eaf66e69bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

