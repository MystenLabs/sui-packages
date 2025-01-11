module 0x52788bbd11655394ff42b589705df6deffb5be883e001c43b9505216631f1c04::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAKA>(arg0, 6, b"KAKA", b"$KAKA | the SUI AI Agent by SuiAI", b"With OrangeBot, enhance your community engagement on the Sui Network using the power of automation and advanced tools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kaka_c0533606d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAKA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

