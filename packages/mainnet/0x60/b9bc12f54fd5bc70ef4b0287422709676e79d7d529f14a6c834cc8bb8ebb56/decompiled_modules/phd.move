module 0x60b9bc12f54fd5bc70ef4b0287422709676e79d7d529f14a6c834cc8bb8ebb56::phd {
    struct PHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHD>(arg0, 6, b"PHD", b"Pic Of Hot Dog", x"5175616e746974793a204f6e652064656c6963696f757320686f7420646f670a4c656e6774683a204a757374207468652072696768742073697a650a5765696768743a20506572666563746c792062616c616e6365640a4167653a205374696c6c20756e646572207265766965770a4177617264733a204120666577207461737479206f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hotdog_Avatar_bdd87c018d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

