module 0xeee0f4a341de62f6ac7135abb51083baecc1c6f3dc07fe5fda0c2c2f6887e3a0::yrnfhfhr {
    struct YRNFHFHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YRNFHFHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YRNFHFHR>(arg0, 9, b"YRNFHFHR", b"Fhfg", b"Fhfgfgr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97a0de3f-b196-4931-a294-abe88ef7f073.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YRNFHFHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YRNFHFHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

