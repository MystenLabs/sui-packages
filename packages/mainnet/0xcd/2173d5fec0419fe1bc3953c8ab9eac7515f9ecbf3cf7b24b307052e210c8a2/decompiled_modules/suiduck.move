module 0xcd2173d5fec0419fe1bc3953c8ab9eac7515f9ecbf3cf7b24b307052e210c8a2::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 9, b"SUIDUCK", b"Sui Duck", b"Just a Sui Duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafkreicb46mpinms3dsvp6oeblrevd63ojv2skllzgj4wiash5woav5rpi"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
        0x2::coin::mint_and_transfer<SUIDUCK>(&mut v2, 1000000000000000000, @0x570a9e66815622d20f8373cc812ff777d53a788ef4244291dc6374039e520878, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDUCK>>(v2);
    }

    // decompiled from Move bytecode v6
}

