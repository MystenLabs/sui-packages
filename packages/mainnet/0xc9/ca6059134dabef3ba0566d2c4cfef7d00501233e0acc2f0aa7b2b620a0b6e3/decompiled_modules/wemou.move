module 0xc9ca6059134dabef3ba0566d2c4cfef7d00501233e0acc2f0aa7b2b620a0b6e3::wemou {
    struct WEMOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMOU>(arg0, 9, b"WEMOU", b"MOU", b"MOU MOU MOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/037cab22-ac70-4c69-8f4a-e7d1fd74bf03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

