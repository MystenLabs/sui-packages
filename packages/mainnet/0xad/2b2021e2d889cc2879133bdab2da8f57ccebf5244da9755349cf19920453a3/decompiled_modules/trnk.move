module 0xad2b2021e2d889cc2879133bdab2da8f57ccebf5244da9755349cf19920453a3::trnk {
    struct TRNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRNK>(arg0, 6, b"TRNK", b"Trunky on SUI", b"Trunky was created by the Dogecoin Dev!!! This is the First Trunky on SUI. TG: https://t.me/trunkyonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trunky_small_185e2de490.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

