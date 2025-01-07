module 0x39592e94e8f5a4af85143bad1c49a9df327b740d478ce562551a93b8e4ee5c09::by153 {
    struct BY153 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY153, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY153>(arg0, 9, b"BY153", b"AIY", b"artificial intelligence towards the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/791bdee7-c064-428e-bd99-a58befed6453.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY153>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY153>>(v1);
    }

    // decompiled from Move bytecode v6
}

