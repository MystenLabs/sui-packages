module 0x575c278511baa83925746dced96f2fdb860bd30b1633e0d014637443fea0022b::rou {
    struct ROU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROU>(arg0, 9, b"ROU", b"ROUND", b"ROUND HEAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7754d103-6feb-4363-8fa4-4dea28efe230.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROU>>(v1);
    }

    // decompiled from Move bytecode v6
}

