module 0xf14eb226f3facb89168eda59c247e61a9d7cc3a3e8a06fe1e68dc46414a5b388::hhh {
    struct HHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHH>(arg0, 9, b"HHH", b"Ffgg", b"Hhhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/51ab0457-0f9b-4c02-a972-b190dae71286.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

