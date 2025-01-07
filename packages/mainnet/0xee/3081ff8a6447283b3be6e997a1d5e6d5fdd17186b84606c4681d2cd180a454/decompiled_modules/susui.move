module 0xee3081ff8a6447283b3be6e997a1d5e6d5fdd17186b84606c4681d2cd180a454::susui {
    struct SUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSUI>(arg0, 6, b"SUSUI", b"SUSUI COIN", b"This is our first Sui project! Me and my little broder. GL for all! Go to Dex guys !!! LFG! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_16_205009_ac990322b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

