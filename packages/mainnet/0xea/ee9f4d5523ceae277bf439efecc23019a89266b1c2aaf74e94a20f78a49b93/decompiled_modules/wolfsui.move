module 0xeaee9f4d5523ceae277bf439efecc23019a89266b1c2aaf74e94a20f78a49b93::wolfsui {
    struct WOLFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFSUI>(arg0, 6, b"WOLFSUI", b"LANDWOLFSUI", b"Forget pixelated JPEGs and bored primates. Landwolf is here to shake up the crypto scene on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_224138451_e4e51f2c21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

