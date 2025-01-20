module 0x665e96e9a599258da8b1cf74a07730438e39e616c1d77e9bd47e512cc73adeb4::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 6, b"ERIC", b"Eric Meme", b"unOfficial Eric Trump Token. Eric is following Sui. It's time for Sui to pump. Those who believe in Sui's vision, buy and hold. $Sui and $ERIC will make you rich. There is no initial site. This is a CTO token.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EFS_6c9c90a810.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

