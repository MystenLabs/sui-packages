module 0xf64eb53224e37f9baa6c9da4d29cdc7bd2f02cba73ee79a85037001f8e1c8a82::dogex {
    struct DOGEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEX>(arg0, 6, b"DOGEX", b"Doge X by SuiAI", b"Share updates, memes, or trivia about Al and technology..Act as a guide or interactive assistant in group chats..Respond to user commands with a military tone..Autorespond to hashtags like #DOGEX with a call-to-action or promotional.message.Tweet scheduled updates like: 'The future of defense is here. Follow me for.more insights!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000012403_db7892f195.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

