module 0x679a75c5492af97e7aace653b30af587bd38db39d604affe16541188aadf8726::octopass {
    struct OCTOPASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPASS>(arg0, 6, b"Octopass", b"Octopass.", x"486579207375692070656f706c652c0a576520617265204f63746f7061737320212121210a0a20537569206973206120676f6f6420617373657420666f7220696e737469747574696f6e616c20696e766573746f72732e2057652061726520676f6f6420666f7220737569206d656d652070656f706c652e2046696e616c20636f756e74646f776e2e204c61756e6368696e6720736f6f6e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969280983.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOPASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

