module 0xebac9eb338b7e22cac9e609db808b51004aa087b2d4a0458179d021c8025a17a::sfui {
    struct SFUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFUI>(arg0, 6, b"SFUI", b"Sufentanil", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://rk.md/wp-content/uploads/2022/06/sufentanil-vial-label.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFUI>(&mut v2, 234562788000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

