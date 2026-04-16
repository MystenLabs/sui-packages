module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::null808 {
    struct NULL808 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NULL808>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NULL808>>(0x2::coin::mint<NULL808>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NULL808, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NULL808>(arg0, 9, b"NULL808", b"36N9 NULL ANCHOR", x"383038204e756c6c20416e63686f72205769746e65737320e28094205a65726f2d706f696e74207265666572656e636520666f722031332d63757272656e63792043424443206d6573682e204669626f6e6163636920737570706c793a20302e20496e737572616e63653a204e2f412e205861686175206973737565723a20724d345a44453642394a6e3163746b793758376a4a533433657739473750336e4b6b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/null808.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NULL808>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NULL808>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

