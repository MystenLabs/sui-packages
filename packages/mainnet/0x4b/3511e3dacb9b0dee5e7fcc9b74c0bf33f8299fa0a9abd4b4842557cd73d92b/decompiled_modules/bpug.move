module 0x4b3511e3dacb9b0dee5e7fcc9b74c0bf33f8299fa0a9abd4b4842557cd73d92b::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"BABY PUG", x"426f726e2066726f6d20746865204f472c2046756420746865205075672c0a244250554720697320726561647920746f20737465616c207468650a73706f746c69676874206f6e205375692120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731933591622.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

