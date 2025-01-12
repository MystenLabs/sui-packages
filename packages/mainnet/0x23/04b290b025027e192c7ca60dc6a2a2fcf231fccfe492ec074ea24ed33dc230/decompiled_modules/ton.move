module 0x2304b290b025027e192c7ca60dc6a2a2fcf231fccfe492ec074ea24ed33dc230::ton {
    struct TON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TON>(arg0, 6, b"TON", b"TonMeme", b"TON meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/a400dba0-ad16-489f-8733-4665c8dc77f2.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

