module 0xe36a75d0140bdc92b57e2c932fa056242af490045a92547332ca076c8d3cb9::zor {
    struct ZOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOR>(arg0, 9, b"ZOR", b"zoro pirate hunter", b"zoro pirate hunter from onepiece anime the world's famous anime.zoro is three sword user, the first person and best friend of luffy the upcoming pirate king and 4rth emperor of the sea at the current state. zoro is the man who wanted to become the number 1 swordsman in the world and he is near to win his title.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6ff2dc6742e01adbacc517f7e301dafdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

