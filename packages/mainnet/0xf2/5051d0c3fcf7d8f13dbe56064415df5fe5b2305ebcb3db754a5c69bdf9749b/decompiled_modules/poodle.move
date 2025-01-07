module 0xf25051d0c3fcf7d8f13dbe56064415df5fe5b2305ebcb3db754a5c69bdf9749b::poodle {
    struct POODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POODLE>(arg0, 9, b"POODLE", b"KemDog", b"This is my poodle dog. His name is Kem. He is so cute and active. I live him so much !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25dee2bb-9d97-4d7e-8ec2-6b790296cf88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POODLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POODLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

