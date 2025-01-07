module 0xb212092172e6e553b551a30d7d33100a10e2e8396963a1a870233e7b9cda95c3::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 9, b"GOKU", b"Goku", b"Goku, Saiyan warrior, & friends search for Dragon Balls, facing enemies to protect Earth. Series follows Goku's growth, sons' journeys, & friends' adventures. They battle Saiyans, Frieza, Cell, & Majin Buu to save the planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1ef3209-ef87-4de6-887f-0a830913f01f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

