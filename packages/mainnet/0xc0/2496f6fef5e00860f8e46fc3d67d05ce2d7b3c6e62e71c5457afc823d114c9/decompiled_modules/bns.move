module 0xc02496f6fef5e00860f8e46fc3d67d05ce2d7b3c6e62e71c5457afc823d114c9::bns {
    struct BNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNS>(arg0, 6, b"BNS", b"Baby Deng Sui", x"4f75722061646f7261626c65206c6974746c6520426162792044656e67206465736572766573206d75636820626574746572207468616e20746865206f6c6420646576207761732070726f766964696e672e0a436f6d6d756e697479206973207374726f6e6720616e642077616e74696e6720746f2073656e640a426162794d6f6f44656e672077686572652069742062656c6f6e677321204c46470a4c657373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0039_9c91831276.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

