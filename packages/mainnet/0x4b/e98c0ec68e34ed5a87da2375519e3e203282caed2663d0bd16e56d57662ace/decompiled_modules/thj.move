module 0x4be98c0ec68e34ed5a87da2375519e3e203282caed2663d0bd16e56d57662ace::thj {
    struct THJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: THJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THJ>(arg0, 9, b"THJ", b"TJK", b"SAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2665e9b-b82b-4c08-82b5-a830106ba1ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

