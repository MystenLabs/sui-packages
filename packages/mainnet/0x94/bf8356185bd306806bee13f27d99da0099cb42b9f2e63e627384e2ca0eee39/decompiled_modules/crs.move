module 0x94bf8356185bd306806bee13f27d99da0099cb42b9f2e63e627384e2ca0eee39::crs {
    struct CRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRS>(arg0, 9, b"CRS", b"Criuse", b"Catch criuse for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17704cde-3459-47f8-9e9b-5443d21e9389.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

