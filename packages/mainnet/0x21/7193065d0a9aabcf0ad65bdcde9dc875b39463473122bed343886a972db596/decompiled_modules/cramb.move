module 0x217193065d0a9aabcf0ad65bdcde9dc875b39463473122bed343886a972db596::cramb {
    struct CRAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAMB>(arg0, 6, b"CRAMB", b"Donald Cramb", b"Once upon the sandy shores of Crabby Cove, there lived a magnificent creature known as Donald Cramb. With his golden shell gleaming under the sun, he was no ordinary crab. Little did the other ocean dwellers know, Donald Cramb was actually a clone of the famous tycoon, Donald Trump. Now he lives in the depths of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yt1211_79bb721651.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

