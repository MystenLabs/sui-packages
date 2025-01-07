module 0xf5afb97ab60958ecf7c50ff48c38485fd6fb4eababd054613a777682fff04de0::WAWACATSUI {
    struct WAWACATSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAWACATSUI>, arg1: 0x2::coin::Coin<WAWACATSUI>) {
        0x2::coin::burn<WAWACATSUI>(arg0, arg1);
    }

    fun init(arg0: WAWACATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWACATSUI>(arg0, 6, b"WCS", b"WAWACATSUI", b"WAWHAAAT ABOUT ? Why did the sneaky Wawa cat jump into $wawa? Saw the market bounce and said, WAAAAWAAAAAAA Hissed at FUD, held tight to its $wawa bags. Diversified into $wawa, $wawa, and $wawa. Now it lounges forward, smug and unbothered! https://wawacat.online/ https://x.com/WawaCat_Sui https://t.me/WawaSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co.com/r38JY1C/photo-2024-10-15-18-44-01.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWACATSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWACATSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAWACATSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WAWACATSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

