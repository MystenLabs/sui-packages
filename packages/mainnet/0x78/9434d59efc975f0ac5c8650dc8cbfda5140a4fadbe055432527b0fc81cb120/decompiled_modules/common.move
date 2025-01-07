module 0x789434d59efc975f0ac5c8650dc8cbfda5140a4fadbe055432527b0fc81cb120::common {
    struct COMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON>(arg0, 9, b"COMMON", b"Common", b"Everything is common no rare, epic, legendary or special", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8bb7b80-81e5-468c-8190-2ad36d914b81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

