module 0xc46788016e01990968a94c90e0c353cc552ddb30f21298ccf6e5162a858f0253::babydoge {
    struct BABYDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGE>(arg0, 9, b"BABYDOGE", b"BABY DOGE", b"Let's join $BABYDOGE to save poor dogs around the world. $BABYDOGE is available on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58399704-96ac-4321-abc6-3749e18ad1cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

