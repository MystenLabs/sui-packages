module 0x7261285392024a46b99adda31403b47b3f3ba6dc582af35359d0111f263a4aa::crimetok {
    struct CRIMETOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRIMETOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRIMETOK>(arg0, 6, b"CRIMETOK", b"CrimeTok on SUI", x"4c61756e6368696e6720746f646179206f6e204d6f766570756d702e200a244352494d45544f4b202d2054686520746f6b656e2077697468206b696c6c657220706f74656e7469616c2e0a4a6f696e20746865206372696d6520776176652e0a446f6e74206d697373206f7574206f6e207468697320627265616b6f75742070726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ze_Zzi_Me_400x400_3afa214d86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRIMETOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRIMETOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

