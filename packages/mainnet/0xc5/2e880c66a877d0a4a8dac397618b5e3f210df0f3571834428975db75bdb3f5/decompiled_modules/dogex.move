module 0xc52e880c66a877d0a4a8dac397618b5e3f210df0f3571834428975db75bdb3f5::dogex {
    struct DOGEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEX>(arg0, 6, b"DOGEX", b"Agent DogeX by SuiAI", b"Share updates, memes, or trivia about Al and technology..Act as a guide or interactive assistant in group chats..Respond to user commands with a military tone..Autorespond to hashtags like #dogeX with a call-to-action or promotional.message.Tweet scheduled updates like: 'The future of defense is here. Follow me for.more insights!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000012403_65e744f05d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

