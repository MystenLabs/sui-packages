module 0x790fe83d4ed80fa9c654f2f22ead4317a8d0ea5d6ebe276fee96eb65fd876aec::bullrun {
    struct BULLRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLRUN>(arg0, 6, b"BullRun", b"BullSui", b"Bull Run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibcvvvz5bb3pzhjhzsbo64sh2odwttdqvbnadtdvtsy67pg4aiqwm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLRUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

