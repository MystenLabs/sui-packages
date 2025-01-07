module 0x3f0f994681bcb3798ba2e23806baf01a7e7b31ca831909e8160783971ae200f7::lmn {
    struct LMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMN>(arg0, 9, b"LMN", b"lemon", x"6c65747320626520726963682077697468206c656d6f6e20f09f8d8bf09f8d8bf09f8d8bf09f8d8b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/847cd439-5416-4fc6-89fd-b9611a17d8b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

