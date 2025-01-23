module 0x128eeb7d0cc2a21b5bb89d37cf87361ff4a21a40cfa121b3265e84f23af9de8a::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 9, b"BRD", b"BORODA ", b"ESLI BORODA NE VIROSLA-KUPI and SOHRANI. HOLD POKA NE VIRASTIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/784eb4cc-f68a-471c-82ef-1932eca70f01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

