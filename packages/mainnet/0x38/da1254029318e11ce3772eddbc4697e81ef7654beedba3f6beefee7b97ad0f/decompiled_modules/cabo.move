module 0x38da1254029318e11ce3772eddbc4697e81ef7654beedba3f6beefee7b97ad0f::cabo {
    struct CABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABO>(arg0, 6, b"CABO", b"CABO DOG", x"46616d20244341424f200a0a5765206c61756e6368656420746869732070726f6a6563742077697468206120677265617420707572706f736520616e6420776520686176652061206d697373696f6e206f66206f7572206f776e200a0a536f6f6e20616e64207374657020627920737465702077652077696c6c2074656c6c20796f7520616c6c2061626f75742069742074", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3582_02855f5a7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABO>>(v1);
    }

    // decompiled from Move bytecode v6
}

