module 0x4d77fcd236095cd5e936828f4bdd5ffbc896bf7e9437889841b049f44c86bd35::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 9, b"SBB", b"SpongeBob", b"Buy a burger at SpongeBob's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cd633de667bdab8fa41e24ef181ffc28blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

