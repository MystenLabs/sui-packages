module 0x459721ae1d7bb94b6f0bf1a18f9c5552ad176ee0a3d30906a85094b8d830871f::prt {
    struct PRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRT>(arg0, 9, b"PRT", b"PARROT", b"h1 w0rld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9be432a-b611-45bc-bef2-8ecdf0b04501.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

