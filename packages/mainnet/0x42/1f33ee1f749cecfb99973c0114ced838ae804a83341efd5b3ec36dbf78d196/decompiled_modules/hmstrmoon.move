module 0x421f33ee1f749cecfb99973c0114ced838ae804a83341efd5b3ec36dbf78d196::hmstrmoon {
    struct HMSTRMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTRMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTRMOON>(arg0, 9, b"HMSTRMOON", b"Hmstr Moon", b"Hamster Kombat to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba17287d-7c9f-414c-84dd-f9e643452cfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTRMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMSTRMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

