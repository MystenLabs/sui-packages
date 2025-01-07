module 0x161db8560a9a939963598f4161be9a26de85dfe6c8282413e95b76de7480ae6c::boowe {
    struct BOOWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOWE>(arg0, 9, b"BOOWE", b"Boowe wog", b"Boowe the wog pepe dogwif doge dogs shiba all memes father", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a190f667-0a4b-43ba-a87a-8402c74d09fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

