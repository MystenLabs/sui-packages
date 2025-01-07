module 0xa75b23f1533ae31537ea80f3587c40475662f641ee57e9c340ef39d6776bcf19::fry {
    struct FRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRY>(arg0, 6, b"FRY", b"SUIFY", x"53756946727920697320667279696e6720757020736f6d657468696e6720637269737079206f6e2074686520626c6f636b636861696e2120436f6d696e6720736f6f6e20746f205355492e2042652063617574696f75736f6e6c79207472757374206f7572206f6666696369616c20706f7374732e2047657420726561647920666f722074616b656f6666210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LAUNCH_SUIFRY_1_4b59167aa1_ba81197985.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

