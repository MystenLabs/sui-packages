module 0x8b04cbad2e84565ca6bb95ec101ae328539c3599e669fa7c57cf159f7e50e764::navanh {
    struct NAVANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVANH>(arg0, 9, b"NAVANH", b"DAN", b"My baby of us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9797f1d8-1ed8-437e-a081-40f08b98605f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

