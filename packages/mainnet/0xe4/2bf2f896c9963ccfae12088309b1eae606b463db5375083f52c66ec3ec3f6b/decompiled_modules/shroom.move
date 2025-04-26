module 0xe42bf2f896c9963ccfae12088309b1eae606b463db5375083f52c66ec3ec3f6b::shroom {
    struct SHROOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHROOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHROOM>(arg0, 9, b"SHROOM", b"SuiShroom", b"SuiShroom sprouted from the mystical gardens of Sui to bring fortune, laughter, and a little magic to the blockchain. Powered by the spirit of memes and community, SHROOM is here to grow, spread, and take over your wallet  one hilarious spore at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c8090744a247f07dc9dd3041d5860cf5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHROOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHROOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

