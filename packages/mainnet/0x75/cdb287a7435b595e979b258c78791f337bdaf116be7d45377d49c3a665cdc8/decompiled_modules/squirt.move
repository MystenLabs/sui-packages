module 0x75cdb287a7435b595e979b258c78791f337bdaf116be7d45377d49c3a665cdc8::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 9, b"SQUIRT", b"SuiSquirt", b"SuiSquirt is the cheeky and speedy mascot of the Sui blockchain universe - combining meme culture with cutting-edge tech. With lightning-fast transactions and unstoppable vibes, $SQUIRT brings the power of the Sui network to the world of fun, community-driven coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/919dcaef88c4b9c46ae0654de57882bablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

