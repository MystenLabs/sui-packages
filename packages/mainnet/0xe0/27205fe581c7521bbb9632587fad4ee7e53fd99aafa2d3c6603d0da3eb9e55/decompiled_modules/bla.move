module 0xe027205fe581c7521bbb9632587fad4ee7e53fd99aafa2d3c6603d0da3eb9e55::bla {
    struct BLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLA>(arg0, 9, b"BLA", b"BLACK HOLE", b"BLACKE HOLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a501aa41-cd0b-46ee-8432-dff5323af98f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

