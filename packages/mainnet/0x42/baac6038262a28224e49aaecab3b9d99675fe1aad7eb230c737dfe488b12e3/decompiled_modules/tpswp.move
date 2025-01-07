module 0x42baac6038262a28224e49aaecab3b9d99675fe1aad7eb230c737dfe488b12e3::tpswp {
    struct TPSWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPSWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPSWP>(arg0, 6, b"TPSWP", b"tapswap", b"Want to see your taps turn into something more? Dive into the app, where every tap opens up exciting possibilities and thrilling experiences! Lets tap our way to success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_Pw_V_Jvhm_400x400_ec0a737c93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPSWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPSWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

