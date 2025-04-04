module 0xe9541351edca769cd2973efda7e14cad951bffe0cb2e492f211cc8bb8cc3ec8f::getrich {
    struct GETRICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GETRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GETRICH>(arg0, 6, b"GETRICH", b"Treasure GetRich", b"towards the animation of time travel that will provide a very exciting and interesting experience, get ready to pump up the adrenaline that will make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053647_88134fd99c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GETRICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GETRICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

