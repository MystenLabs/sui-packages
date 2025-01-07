module 0x653efc03ae0d98caef8bf7977796ccd78351adb64e1eca106a11265b386f910c::clawy {
    struct CLAWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWY>(arg0, 6, b"CLAWY", b"SUI CLAWY", b"I AM MEME TOKEN IN SUI WORLD AND ONLY UNIQUE CREATURE IN THE WORLD FULL OF DOGIEES / CATS/ FISHIEES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_476798589_612x612_dfbe4d578b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

