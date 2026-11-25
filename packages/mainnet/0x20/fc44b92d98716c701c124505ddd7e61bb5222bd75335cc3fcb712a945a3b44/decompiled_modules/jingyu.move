module 0x20fc44b92d98716c701c124505ddd7e61bb5222bd75335cc3fcb712a945a3b44::jingyu {
    struct JINGYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINGYU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795566917603-dc6b0283c34192583607a394d07ebacf.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795566917603-dc6b0283c34192583607a394d07ebacf.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<JINGYU>(arg0, 9, b"jingyu", b"The Great Whale", b"buybuybuby", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<JINGYU>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINGYU>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JINGYU>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

