module 0xd0f0834869079b57386d3c9d5c964c26899ca17e5dfec644e093610db0e8673f::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIME>(arg0, 9, b"Anime", b"Coin of the anime market", b"We are Anime fans, this is a coin born to celebrate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e9cd157b2fde8f2864c5a065a64d7523blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

