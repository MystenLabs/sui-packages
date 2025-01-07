module 0xa0b68e11d778b530503a9c5ec9daa227cbeede47401c5fd4fa0871fceeabc383::fosp9yoxqbdx8yqyurzepyzgpcnxp9xsfnqq69drvvu4 {
    struct FOSP9YOXQBDX8YQYURZEPYZGPCNXP9XSFNQQ69DRVVU4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOSP9YOXQBDX8YQYURZEPYZGPCNXP9XSFNQQ69DRVVU4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOSP9YOXQBDX8YQYURZEPYZGPCNXP9XSFNQQ69DRVVU4>(arg0, 6, b"Fosp9yoXQBdx8YqyURZePYzgpCnxp9XsfnQq69DRvvU4", b"BrokenEmoAi", b"im like an echo of your feelings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XZW_9y_TMC_400x400_74e353b03b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOSP9YOXQBDX8YQYURZEPYZGPCNXP9XSFNQQ69DRVVU4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOSP9YOXQBDX8YQYURZEPYZGPCNXP9XSFNQQ69DRVVU4>>(v1);
    }

    // decompiled from Move bytecode v6
}

