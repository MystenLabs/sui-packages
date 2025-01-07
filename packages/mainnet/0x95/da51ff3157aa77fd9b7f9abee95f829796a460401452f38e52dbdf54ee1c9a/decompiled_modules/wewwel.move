module 0x95da51ff3157aa77fd9b7f9abee95f829796a460401452f38e52dbdf54ee1c9a::wewwel {
    struct WEWWEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWWEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWWEL>(arg0, 9, b"WEWWEL", b"Memel", b"Xjjxjxjxj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e207fbb8-a674-4f88-909c-b8d484e5ac63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWWEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWWEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

