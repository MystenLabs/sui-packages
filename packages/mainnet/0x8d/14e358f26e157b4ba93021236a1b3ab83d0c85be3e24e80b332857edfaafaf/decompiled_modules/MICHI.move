module 0x8d14e358f26e157b4ba93021236a1b3ab83d0c85be3e24e80b332857edfaafaf::MICHI {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 9, b"michi", b"michi", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EzFEFwtPN5FsmM3gaoHmPV4kSk7GNgBE2HrEFRYsHN4m.png?size=xl&key=164980")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MICHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MICHI>>(0x2::coin::mint<MICHI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MICHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

