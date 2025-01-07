module 0xcd0756aa1f71f1d108dff31e55dca817226d004ffc733c2219e05e67b9b147d7::axos {
    struct AXOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOS>(arg0, 6, b"AXOS", b"AXOS on SUI", b"$AXOS is a cute, fast-swimming, Sui-themed cyber axolotl making waves on  Sui. Dive into the future with $AXOS, and let this little creature take you on a rapid journey through the project seas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AXOS_afdea408de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

