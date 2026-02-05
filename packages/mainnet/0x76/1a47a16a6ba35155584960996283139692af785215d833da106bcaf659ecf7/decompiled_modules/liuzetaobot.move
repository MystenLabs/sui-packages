module 0x761a47a16a6ba35155584960996283139692af785215d833da106bcaf659ecf7::liuzetaobot {
    struct LIUZETAOBOT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIUZETAOBOT>, arg1: 0x2::coin::Coin<LIUZETAOBOT>) {
        0x2::coin::burn<LIUZETAOBOT>(arg0, arg1);
    }

    fun init(arg0: LIUZETAOBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIUZETAOBOT>(arg0, 6, b"liuzetaobot", b"liuzetaobot", b"liuzetaobot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1574215476875403264/rOFCHQuR_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIUZETAOBOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIUZETAOBOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIUZETAOBOT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIUZETAOBOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

