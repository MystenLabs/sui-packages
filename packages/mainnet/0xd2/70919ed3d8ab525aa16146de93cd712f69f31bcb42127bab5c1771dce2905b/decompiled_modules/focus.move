module 0xd270919ed3d8ab525aa16146de93cd712f69f31bcb42127bab5c1771dce2905b::focus {
    struct FOCUS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOCUS>, arg1: 0x2::coin::Coin<FOCUS>) {
        0x2::coin::burn<FOCUS>(arg0, arg1);
    }

    fun init(arg0: FOCUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOCUS>(arg0, 9, b"FOCUS", b"FOCUS", b"PLEASE FOCUS?! ON A HARD DAY OR NITE LIKE TODAY, FOCUS ON WHAT MATTERS. MOVING AROUND, PLAYING, CRUISING, EXTREME SPORTS, SPORTING EVENTS, EITHER BEING IN THEM, OR JUST WATCHING. REMEMBER TO FUCUS AND DIAL IN THAT AMERICAN SPIRIT AND ATTITUDE. PAYING CLOSE ATTENTION TO DETAIL HELPS TO MAKE YOUR DAY RUN SMOOTHLY. THIS IS NOT FINANCIAL ADVICE AND I AM NOT LIABLE FOR FINANTIAL LOSS OF ANY TYPE. PLEASE USE AT YOUR OWN RISK. COPYRIGHTS AND TRADEMARKS ALL PROPERTY OF R.S.D 2026-2029", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaw5rylwzvsgt2ojb5igbd2k7pt23b6vvkya3fhio6j7n7n7mph4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOCUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOCUS>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOCUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOCUS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

