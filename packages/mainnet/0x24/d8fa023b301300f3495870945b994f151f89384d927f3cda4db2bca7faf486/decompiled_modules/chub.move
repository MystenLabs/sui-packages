module 0x24d8fa023b301300f3495870945b994f151f89384d927f3cda4db2bca7faf486::chub {
    struct CHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUB>(arg0, 6, b"CHUB", b"Fat Baby", b"Fat Baby is a unique cryptocurrency project centered around creating and sharing hilarious fat baby memes of celebrities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732592164227.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

