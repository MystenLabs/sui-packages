module 0xea6400fd85ee23a2ddc38e51444e350b44391218a0caf1bfe7c7f23bade9feb6::nik {
    struct NIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIK>(arg0, 9, b"NIK", b"Nikzo", b"An inspired newbea in the crypto space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff66c172-977b-4455-92d8-3d5c27ac07e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

