module 0x60df23c3745cd22b8a2b8a9041d07fda51a992d03b3dd05295f7e9d9869c361a::wegom {
    struct WEGOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEGOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEGOM>(arg0, 9, b"WEGOM", b"WEWEGOMBEL", b"Wewegombel is a ghost in indonesia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55d7c24d-bbfa-4fc3-a859-16e3f976718c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEGOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEGOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

