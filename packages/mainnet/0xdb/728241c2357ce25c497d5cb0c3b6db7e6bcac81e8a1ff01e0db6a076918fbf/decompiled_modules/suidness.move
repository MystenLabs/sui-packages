module 0xdb728241c2357ce25c497d5cb0c3b6db7e6bcac81e8a1ff01e0db6a076918fbf::suidness {
    struct SUIDNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDNESS>(arg0, 6, b"SUIDNESS", b"Suidness", b"Get ready to embrace the emotional side of memecoins with $SUIDNESS, a clever blend of \"Sadness\" from Inside Out and the powerful SUI Network. In a world that constantly chases highs, $SUIDNESS offers a unique reflection on the ups and downs of the crypto journey, where even sadness has its place. Built on SUI, the network known for its speed and efficiency, $SUIDNESS stands as a reminder that not every day is a bullrun... and that's perfectly fine!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_ede55423e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDNESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDNESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

