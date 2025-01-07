module 0x3307a4f6f8ccdaeba2f7023d3fc9c080c384c505f986690865acaa13d28b7f6d::dfjfk {
    struct DFJFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFJFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFJFK>(arg0, 9, b"DFJFK", b"Ausjsnd", b"Xjfkfkv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7748ddd-7e20-4e72-8f0a-2c50676ec7fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFJFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFJFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

