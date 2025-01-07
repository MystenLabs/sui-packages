module 0x9e628e3dd27ea2bc8a1e7743b3fcd06bacb4d28fc0f6e627ba7259fa6811c21a::ustd {
    struct USTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USTD>(arg0, 6, b"USTD", b"Teter On Sui", b"To won dollah u degeneraz, the new meta is here, and is ours, together united to make history. [ Telegram : https://t.me/ustdteteronsui ] [ Twitter : https://twitter.com/ustdtetersui ] [ Website : https://teterustd.fun ]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_ca18293323.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

