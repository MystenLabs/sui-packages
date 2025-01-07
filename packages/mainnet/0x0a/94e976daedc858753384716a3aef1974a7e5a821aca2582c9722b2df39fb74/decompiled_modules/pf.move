module 0xa94e976daedc858753384716a3aef1974a7e5a821aca2582c9722b2df39fb74::pf {
    struct PF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PF>(arg0, 9, b"PF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24068a7d-49d9-4a7a-863a-7484d3712d0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PF>>(v1);
    }

    // decompiled from Move bytecode v6
}

