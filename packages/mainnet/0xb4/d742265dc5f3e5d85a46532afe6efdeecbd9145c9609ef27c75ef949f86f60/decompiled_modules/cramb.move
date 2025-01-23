module 0xb4d742265dc5f3e5d85a46532afe6efdeecbd9145c9609ef27c75ef949f86f60::cramb {
    struct CRAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRAMB>(arg0, 6, b"CRAMB", b"Donald Cramb by SuiAI", b"Once upon the sandy shores of Crabby Cove, there lived a magnificent creature known as Donald Cramb. With his golden shell gleaming under the sun, he was no ordinary crab. Little did the other ocean dwellers know, Donald Cramb was actually a clone of the famous tycoon, Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/yt1211_1_96dbe2027d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRAMB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAMB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

