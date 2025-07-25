module 0xe7cc78dd7ac8160862f326576b5cc43054f28fe4ec89aab6cdc830e90fa0b4a5::chems {
    struct CHEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEMS>(arg0, 9, b"CHEMS2", b"CHEMS2 Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_EavwKERmVAm-8nDKnd8PrCO1sXhyVpLyPA&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEMS>(&mut v2, 1000000000000000000, @0x519fbd5bf1a0172e756473d88916e27aeb820abadf937b693ff1b80ff66f7760, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEMS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

