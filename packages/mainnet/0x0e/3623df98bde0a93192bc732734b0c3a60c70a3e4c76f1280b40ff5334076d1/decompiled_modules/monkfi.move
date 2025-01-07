module 0xe3623df98bde0a93192bc732734b0c3a60c70a3e4c76f1280b40ff5334076d1::monkfi {
    struct MONKFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKFI>(arg0, 6, b"MonkFI", b"MonkeyFi", x"5468652066697273742d6576657220736f6369616c2065786368616e6765206f6e205355492c20626563617573650a63656e7472616c697a65642065786368616e67657320646f6e2774206861766520746f20626520626f72696e67210a4d6f6e6b65792046696e616e63652068617320612076617269657479206f662066656174757265732074686174206d616b6520697420746865206265737420706c61636520746f2073746172742074726164696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_18_10_06_35_21a59b873d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

