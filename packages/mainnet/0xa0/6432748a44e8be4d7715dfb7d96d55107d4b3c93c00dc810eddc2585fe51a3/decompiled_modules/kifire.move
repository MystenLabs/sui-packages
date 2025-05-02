module 0xa06432748a44e8be4d7715dfb7d96d55107d4b3c93c00dc810eddc2585fe51a3::kifire {
    struct KIFIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIFIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIFIRE>(arg0, 6, b"KIFIRE", b"Fire Kitty", x"4865792049276d204b696669726520746865206368616f7469632066697265206b69747479206c616e646564206f6e205375692e205468652074726f75626c656d616b65722c20746865206368616f7320737461727465722c20746865206f6e652077686f206b65657073207468696e677320696e746572657374696e672e204275636b6c652075702c2068756d616e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kifire_logo_82f651d390.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIFIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIFIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

