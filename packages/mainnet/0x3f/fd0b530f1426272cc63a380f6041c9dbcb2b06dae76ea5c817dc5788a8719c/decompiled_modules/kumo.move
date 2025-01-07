module 0x3ffd0b530f1426272cc63a380f6041c9dbcb2b06dae76ea5c817dc5788a8719c::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 9, b"KUMO", b"Kumo The Cat", b"A clumsy cat has entered the chat - Kumothekat.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1821538395841060866/ZCyh88yJ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KUMO>>(0x2::coin::mint<KUMO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KUMO>>(v2);
    }

    // decompiled from Move bytecode v6
}

