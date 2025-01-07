module 0x4332a1d0dc1131202505989bf61bc5d3b9326ef30d0b6f687df293c152c2547c::ibj {
    struct IBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBJ>(arg0, 9, b"IBJ", b"IBJAAD ", b"IBJAAD IS VERSATILE AND HERE TO STAY, HUMAN PROTOCOL SERVICE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ae42d51-8546-4ee9-a0eb-2e1bbb63cdec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

