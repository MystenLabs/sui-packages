module 0x2afb22dc5c9f96edd52a9da3528d894dbaf02dd96965f336835eb30dd1ee07b7::DAME {
    struct DAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAME>(arg0, 6, b"DAME", b"Dame Tu Cosita", b"Dame tu cosita ah ay dame tu cosita ah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmaXH1mfDnvjcSAU9ZmQ4uiN5xoXeB1YhGHSfXUUGGfzhD")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

