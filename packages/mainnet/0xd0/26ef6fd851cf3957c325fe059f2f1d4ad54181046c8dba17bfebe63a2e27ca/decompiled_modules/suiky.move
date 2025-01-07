module 0xd026ef6fd851cf3957c325fe059f2f1d4ad54181046c8dba17bfebe63a2e27ca::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"$SUIKY", b"Great! Let's welcome everyone to the $SUIKY .meme group on Sui network! This will be where we share funny memes, update the latest news about Sui and connect with the community of Sui lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Launch_now_6_0f423ae872.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

