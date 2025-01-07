module 0xcdc0794b4d792e9eb2cda061b03718ffe347129254e0a99771a3ae66c199cf9b::suikull {
    struct SUIKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKULL>(arg0, 6, b"Suikull", b"SuiSkull", b"In the digital wasteland of blockchain, a skull totem rises, its eye sockets dancing with the ethereal blue flames of Ethereum. This is no longer a symbol of death, but an embodiment of decen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730440579886.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

