module 0xfb45b14fdbe95570acde0773987ea42e950ee791c46cfcdea698784af389fa62::sqd {
    struct SQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQD>(arg0, 6, b"SQD", b"Suicide Squad", b"Introducing the SUICIDE SQUAD-This isn't just any meme coin; it's your ticket to the wildest, most unpredictable adventure in the crypto universe. This All-Star Meme Team is so hilariously mismatched, it might just save the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736874292992.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

