module 0x24c1a3471c60ce2e6ca284b341a178862ca30a956dc9d64b2544fa29dad16c21::monkosui {
    struct MONKOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKOSUI>(arg0, 6, b"MONKOSUI", b"MONKO", b"This is $MONKOSUI , he's ready to eat some bananas. Now, MONKO's gonna be on SUI, ready to take over all meme coins and show whos the King Kong of the area.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_32_3741449302.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

