module 0xd8e78b1e1fa61fc1fc3feede3fc46434bc774d1891c9aab2f215283c5531e347::truwn {
    struct TRUWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUWN>(arg0, 9, b"TRUWN", b"TRUMPWIN", b"Trump winning the election is a win for crypto community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5da974dc-3039-4b62-87bf-b086a663a74d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

