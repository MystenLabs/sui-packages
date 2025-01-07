module 0x185a0aaafe2f24ee16c752c61540d7823b3a4d595189377e9cdfb2bae8b6ffb3::megabot {
    struct MEGABOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGABOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGABOT>(arg0, 6, b"Megabot", b"MEGABOT", b"We are proud to announce the launch of $Megabot, a new token operating on the SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241101_122535_d8d134e86c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGABOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGABOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

