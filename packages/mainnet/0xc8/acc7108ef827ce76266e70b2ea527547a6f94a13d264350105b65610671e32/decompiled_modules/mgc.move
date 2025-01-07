module 0xc8acc7108ef827ce76266e70b2ea527547a6f94a13d264350105b65610671e32::mgc {
    struct MGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGC>(arg0, 9, b"MGC", b"MAGICER", b"COIN OF MAGICER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af09d480-f879-4f37-9c68-dc637bb45ce4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

