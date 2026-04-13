module 0x3b97bcc9ac9c510d2b0bd30154266fc0088537a9fc34f1e4e751cb9df1941e0d::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISE>(arg0, 6, b"RISE", b"NASA ZGI Moon Mascot", x"245249534520e29aa10a4275696c74206f6e205375690a3130303078206c6f6164696e67e280a620e28fb30a446f6ee280997420666164652e204a757374206170652e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1776074923971.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RISE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

