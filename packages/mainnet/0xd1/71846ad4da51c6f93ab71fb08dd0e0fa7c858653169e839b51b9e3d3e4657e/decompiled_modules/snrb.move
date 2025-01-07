module 0xd171846ad4da51c6f93ab71fb08dd0e0fa7c858653169e839b51b9e3d3e4657e::snrb {
    struct SNRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNRB>(arg0, 9, b"SNRB", b"Snow Rabit", b"Rabit in the Snow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed2e5bab-bb90-4d84-92d6-6d847c8bd1cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

