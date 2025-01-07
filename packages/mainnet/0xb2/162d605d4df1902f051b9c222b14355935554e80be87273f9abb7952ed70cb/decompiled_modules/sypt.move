module 0xb2162d605d4df1902f051b9c222b14355935554e80be87273f9abb7952ed70cb::sypt {
    struct SYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYPT>(arg0, 6, b"SYPT", b"Syrian Pound Tether", b"After the end of the Syrian Civil War, Syrian Pound(SYP) has surged. Let's ride the trend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734148625576.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

