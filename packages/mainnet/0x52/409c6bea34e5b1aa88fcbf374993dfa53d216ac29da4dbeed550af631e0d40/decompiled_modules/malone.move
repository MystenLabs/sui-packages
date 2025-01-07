module 0x52409c6bea34e5b1aa88fcbf374993dfa53d216ac29da4dbeed550af631e0d40::malone {
    struct MALONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALONE>(arg0, 6, b"MALONE", b"Rich Malone", b"MALONE has arrived to rock the cryptoworld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RICH_DEV_1_22528d568b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

