module 0xe13e4d7c9341956f2ed072e44943148144a558b90dc1277cb1e30cab9abcbad4::zeny {
    struct ZENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENY>(arg0, 6, b"ZENY", b"Zeny", b"ZENY is an ancient currency. It is an ancient currency that still circulates on an artificial island called Dezima, which is said to be somewhere in the Land of Flame.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1726607623260_8c6be1db650a34ef2166c485f7524ab2_d51d4d6d52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENY>>(v1);
    }

    // decompiled from Move bytecode v6
}

