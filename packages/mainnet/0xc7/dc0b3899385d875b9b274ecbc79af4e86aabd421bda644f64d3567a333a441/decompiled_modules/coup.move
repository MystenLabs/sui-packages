module 0xc7dc0b3899385d875b9b274ecbc79af4e86aabd421bda644f64d3567a333a441::coup {
    struct COUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUP>(arg0, 6, b"COUP", b"COUPON", b"Coupon (COUP) is a memecoin with a mission: to reward every crypto enthusiast on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/COUPON_35ac1def16.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

