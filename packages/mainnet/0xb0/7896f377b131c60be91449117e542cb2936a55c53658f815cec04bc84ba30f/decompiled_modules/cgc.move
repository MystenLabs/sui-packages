module 0xb07896f377b131c60be91449117e542cb2936a55c53658f815cec04bc84ba30f::cgc {
    struct CGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGC>(arg0, 9, b"CGC", b"Celestial griffin coming", b"A celestial griffin has fallen from the heavens and wants all your Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a139ac94ef3a4b98256a205fb994688ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

