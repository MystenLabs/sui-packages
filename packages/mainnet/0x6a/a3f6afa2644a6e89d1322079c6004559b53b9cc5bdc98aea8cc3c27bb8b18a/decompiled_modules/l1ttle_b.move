module 0x6aa3f6afa2644a6e89d1322079c6004559b53b9cc5bdc98aea8cc3c27bb8b18a::l1ttle_b {
    struct L1TTLE_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: L1TTLE_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L1TTLE_B>(arg0, 9, b"L1TTLE_B", b"ALittle bb", b"A baby as the beginning of something great unknown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac40f6e2-8bb5-4756-82a9-5a42c5652a0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L1TTLE_B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L1TTLE_B>>(v1);
    }

    // decompiled from Move bytecode v6
}

