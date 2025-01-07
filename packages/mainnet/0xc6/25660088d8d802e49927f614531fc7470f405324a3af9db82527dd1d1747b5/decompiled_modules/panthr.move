module 0xc625660088d8d802e49927f614531fc7470f405324a3af9db82527dd1d1747b5::panthr {
    struct PANTHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANTHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANTHR>(arg0, 6, b"PANTHR", b"SUI Panther", b"The SUI Panther, prowling through the digital jungle, guarding the SUI network with stealth and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1x1_4355658947.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANTHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANTHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

