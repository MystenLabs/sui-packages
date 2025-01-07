module 0x9a9a938f2d7254b67e26d34fc5f2bf283752c706bbce34f7974274d30b816aa4::mdc {
    struct MDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDC>(arg0, 9, b"MTEST1", b"MTEST", b"MTEST Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/yx9GyvRP/image.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDC>>(v1);
        0x2::coin::mint_and_transfer<MDC>(&mut v2, 1000000000000000000, @0xc8008f590b556643edebfd9bd1ca9e64894007ad0536df70b0d845ff5d8db73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDC>>(v2, @0xc8008f590b556643edebfd9bd1ca9e64894007ad0536df70b0d845ff5d8db73);
    }

    // decompiled from Move bytecode v6
}

