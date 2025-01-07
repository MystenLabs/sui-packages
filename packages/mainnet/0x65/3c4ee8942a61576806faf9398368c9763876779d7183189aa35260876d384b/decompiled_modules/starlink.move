module 0x653c4ee8942a61576806faf9398368c9763876779d7183189aa35260876d384b::starlink {
    struct STARLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARLINK>(arg0, 9, b"STARLINK", b"LINKS", b"Token inspired by Internet Enthusiast, to subsidize Internet networks, making it affordable to less privildeged and to underdeveloped and developing countries", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7f536df-9e46-455d-89cf-f19b4e544a4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

