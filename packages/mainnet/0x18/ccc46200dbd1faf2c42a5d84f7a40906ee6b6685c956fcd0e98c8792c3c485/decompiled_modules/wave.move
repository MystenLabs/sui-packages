module 0x18ccc46200dbd1faf2c42a5d84f7a40906ee6b6685c956fcd0e98c8792c3c485::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"Sunami", b"Sunami narrative", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1639006959256084480/5n3Cdt1D.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAVE>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

