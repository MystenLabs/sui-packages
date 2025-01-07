module 0xba1b42e102f3181ef890e83005cc81a57289d7435b397634ea956dd0fde7ab3c::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 9, b"POPDENG", b"Popdeng", b"Viral lil hippo that pops, now popping on the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AtakVE4hj5KgbS58YzmCYrUwRqMNCnwaamUckk2Zpump.png?size=lg&key=66dcf6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPDENG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

